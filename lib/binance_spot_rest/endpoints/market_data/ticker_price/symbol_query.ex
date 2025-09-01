defmodule BinanceSpotRest.Endpoints.MarketData.TickerPrice.SymbolQuery do
  @moduledoc """
             Ticker Price - Symbol query

             """ <> BinanceSpotRest.Endpoints.MarketData.TickerPrice.Endpoint.moduledoc()

  defstruct [:symbol]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.TickerPrice.Endpoint.metadata(),
        query: q
      }
  end
end
