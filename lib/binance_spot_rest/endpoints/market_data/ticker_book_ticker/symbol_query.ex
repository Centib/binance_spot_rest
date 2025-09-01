defmodule BinanceSpotRest.Endpoints.MarketData.TickerBookTicker.SymbolQuery do
  @moduledoc """
             Ticker Book Ticker - Symbol query

             """ <> BinanceSpotRest.Endpoints.MarketData.TickerBookTicker.Endpoint.moduledoc()

  defstruct [:symbol]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.TickerBookTicker.Endpoint.metadata(),
        query: q
      }
  end
end
