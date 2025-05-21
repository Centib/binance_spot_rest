defmodule BinanceSpotRest.Query.QueryString do
  @moduledoc false
  defp empty({_key, value}), do: value == nil or value == []

  defp convert_to_string({key, value}) do
    case value do
      va when is_list(va) -> {key, JSON.encode!(va)}
      va when is_struct(va, Decimal) -> {key, Decimal.to_string(va, :normal)}
      _ -> {key, value}
    end
  end

  def create(%{} = query) do
    query
    |> Enum.reject(&empty/1)
    |> Enum.map(&convert_to_string/1)
    |> URI.encode_query()
  end

  def attach(query_string, %{} = query) do
    "#{query_string}&#{create(query)}"
  end

  def attach_timestamp(query_string, timestamp) do
    attach(query_string, %{timestamp: timestamp})
  end

  def attach_signature(query_string, secret_key) do
    signature = BinanceSpotRest.Query.Signature.create(query_string, secret_key)
    attach(query_string, %{signature: signature})
  end
end
