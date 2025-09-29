defmodule BinanceSpotRest.Validators.RecvWindow do
  @moduledoc """
  Internal

  Validates `recvWindow` values.

  Rules:
    - Must be an integer or a `Decimal`.
    - Must be between 0 and 60000.
    - If a `Decimal`, supports up to 3 decimal places of precision.
  """

  @behaviour Valpa.CustomValidator

  @max_value Decimal.new("60000")
  @min_value Decimal.new("0")
  @max_decimal_places 3

  @doc """
  Returns `:ok` if `recvWindow` is valid, `{:error, msg}` otherwise.

  ## Examples

      iex> BinanceSpotRest.Validators.RecvWindow.validate(5000)
      :ok

      iex> BinanceSpotRest.Validators.RecvWindow.validate(Decimal.new("50.123"))
      :ok

      iex> {:error, _} = BinanceSpotRest.Validators.RecvWindow.validate(70000)

      iex> {:error, _} = BinanceSpotRest.Validators.RecvWindow.validate(Decimal.new("44.4440"))

      iex> {:error, _} = BinanceSpotRest.Validators.RecvWindow.validate(-5)
  """
  @impl true
  def validate(value) do
    if valid?(value) do
      :ok
    else
      {:error,
       Valpa.Error.new(
         validator: :recvWindow,
         value: value,
         criteria: %{
           type: [:integer, :decimal],
           decimal_places_up_to: @max_decimal_places,
           max: 60_000,
           min: 0
         },
         text:
           ~s/expected: recvWindow ≥ 0 and ≤ 60000 (integer or decimal with up to 3 decimal places), got: #{inspect(value)}/
       )}
    end
  end

  # Integer case
  defp valid?(v) when is_integer(v), do: v >= 0 and v <= 60_000

  # Decimal case
  defp valid?(%Decimal{} = v) do
    Decimal.compare(v, @min_value) in [:eq, :gt] and
      Decimal.compare(v, @max_value) in [:eq, :lt] and
      Decimal.scale(v) <= @max_decimal_places
  end

  # Anything else is invalid
  defp valid?(_), do: false
end
