defmodule BinanceSpotRest.Validators.WindowSize do
  @moduledoc """
  Validates `windowSize` values.

  Supported values:
    - Minutes: "1m" to "59m"
    - Hours:   "1h" to "23h"
    - Days:    "1d" to "7d"
  """

  @behaviour Valpa.CustomValidator

  @doc """
  Returns :ok if `ws` is a valid window size, {:error, msg} otherwise.

  ## Examples

      iex> BinanceSpotRest.Validators.WindowSize.validate("15m")
      :ok

      iex> {:error, _} = BinanceSpotRest.Validators.WindowSize.validate("24h")

      iex> {:error, _} = BinanceSpotRest.Validators.WindowSize.validate(:"3d")
  """
  @impl true
  def validate(value) do
    if valid?(value) do
      :ok
    else
      {:error,
       Valpa.Error.new(
         validator: :windowSize,
         value: value,
         criteria: BinanceSpotRest.Enums.WindowSize.values(),
         text:
           ~s/Expected: windowSize value (minutes: "1m" to "59m"), (hours: "1h" to "23h"), (days: "1d" to "7d"), got: #{inspect(value)}/
       )}
    end
  end

  defp valid?(ws) when is_binary(ws), do: ws in BinanceSpotRest.Enums.WindowSize.values()
  defp valid?(_), do: false
end
