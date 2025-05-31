defmodule BinanceSpotRest.Endpoints.MarketData.Ticker.SymbolQuery do
  @moduledoc """
  Symbol query
  """

  defstruct [:symbol, :windowSize, :type]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.Custom.maybe_validator(:windowSize, BinanceSpotRest.Validators.WindowSize)
        |> Valpa.maybe_value_of_values(:type, BinanceSpotRest.Enums.Type.values())

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.Ticker.Endpoint.metadata(),
        query: q
      }
  end
end
