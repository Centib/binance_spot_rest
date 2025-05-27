defmodule Valpa.Predicate.Validator do
  @moduledoc """
  Functions that return boolean
  """
  use Valpa.Predicate.MaybeGenerator

  def integer(va), do: is_integer(va)

  def float(va), do: is_float(va)

  def string(va), do: is_binary(va) and String.valid?(va)

  def boolean(va), do: is_boolean(va)

  def list(va), do: is_list(va)

  def uniq_list(va), do: is_list(va) and Enum.uniq(va) == va

  def map(va), do: is_map(va)

  def nonempty_map(va), do: map(va) and va != %{}

  def list_of_type(va, type) when is_atom(type) do
    is_list(va) and Enum.all?(va, fn elem -> apply(__MODULE__, type, [elem]) end)
  end

  def list_of_values(va, values) when is_list(values) do
    is_list(va) and Enum.all?(va, fn elem -> elem in values end)
  end

  def uniq_list_of_type(va, type) when is_atom(type) do
    uniq_list(va) and list_of_type(va, type)
  end

  def uniq_list_of_values(va, values) when is_list(values) do
    uniq_list(va) and list_of_values(va, values)
  end

  def value_of_values(va, values) do
    va in values
  end

  def value_or_list_of_values(va, values) do
    value_of_values(va, values) or list_of_values(va, values)
  end

  def value_or_uniq_list_of_values(va, values) do
    value_of_values(va, values) or uniq_list_of_values(va, values)
  end

  def integer_in_range(va, range) do
    integer(va) and va >= range.min and va <= range.max
  end

  def list_of_length(va, length) do
    le = length(va)
    list(va) and le >= length.min and le <= length.max
  end

  def uniq_list_of_length(va, length) do
    le = length(va)
    uniq_list(va) and le >= length.min and le <= length.max
  end

  def map_inclusive_keys(va, keys) do
    nonempty_map(va) and Enum.any?(keys, &Map.has_key?(va, &1))
  end

  def map_exclusive_keys(va, keys) do
    present_keys = Enum.filter(keys, &Map.has_key?(va, &1))
    nonempty_map(va) and length(present_keys) == 1
  end

  def map_exclusive_optional_keys(va, keys) do
    Enum.count(keys, &Map.has_key?(va, &1)) <= 1
  end

  def decimal(va), do: is_struct(va, Decimal)
end
