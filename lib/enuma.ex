defmodule Enuma do
  @moduledoc """
  Provides enum-like macros.

  You can pass a mixed list of plain values and keyword pairs.

  ## Usage

  When the enum names and values are the same:

      use Enuma, ["FULL", "1M"]

  This will generate macros like:

      defmacro _full(), do: "FULL"
      defmacro _1m(), do: "1M"   # "1M" starts with a digit so it is prefixed with an underscore.

  When you want to specify different names and values:

      use Enuma, [M3: "3m", MINI: "MINI"]

  This will generate macros like:

      defmacro _m3(), do: "3m"
      defmacro _mini(), do: "MINI"

  When using a function returning a list:

      use Enuma, fn -> ["A", "B", "C"] end

  ## Examples

      iex> defmodule MyEnums do
      ...>   use Enuma, ["FULL", "1M", M3: "3m", mini: "MINI"]
      ...> end
      iex> MyEnums._FULL()
      "FULL"
      iex> MyEnums._1M()
      "1M"
      iex> MyEnums._M3()
      "3m"
      iex> MyEnums._mini()
      "MINI"
      iex> MyEnums.values()
      ["FULL", "1M", "3m", "MINI"]
      iex> defmodule A do use Enuma, [%{}] end
      ** (ArgumentError) Invalid Enuma list value: %{}, expected type: atom, binary or integer
  """

  # Helper to convert a value to a valid macro key.
  # Always prepends an underscore and downcases the string representation.

  defmacro __using__(values) do
    quote bind_quoted: [values: values] do
      underscore_string = fn
        v when is_binary(v) -> String.to_atom("_" <> v)
      end

      underscore = fn
        v when is_binary(v) -> v |> underscore_string.()
        v when is_atom(v) -> v |> Atom.to_string() |> underscore_string.()
        v when is_integer(v) -> v |> Integer.to_string() |> underscore_string.()
      end

      values = if is_function(values), do: values.(), else: values

      kv =
        if is_list(values) do
          Enum.map(values, fn
            {k, v} when is_atom(k) ->
              {underscore.(k), v}

            {k, _} ->
              raise ArgumentError,
                    "Invalid Enuma keyword: #{inspect(k)}, expected type: atom"

            v when is_atom(v) or is_binary(v) or is_integer(v) ->
              {underscore.(v), v}

            v ->
              raise ArgumentError,
                    "Invalid Enuma list value: #{inspect(v)}, expected type: atom, binary or integer"
          end)
        else
          raise ArgumentError, "use Enuma expects a list or keyword list"
        end

      for {key, val} <- kv do
        def unquote(key)(), do: unquote(val)
      end

      def values(), do: unquote(Enum.map(kv, &elem(&1, 1)))
      def keys(), do: unquote(Enum.map(kv, &elem(&1, 0)))
      def all(), do: unquote(kv)
    end
  end
end
