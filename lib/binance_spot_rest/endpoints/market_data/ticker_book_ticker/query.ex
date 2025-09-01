defmodule BinanceSpotRest.Endpoints.MarketData.TickerBookTicker.Query do
  @moduledoc """
             Ticker Book Ticker - Empty query

             """ <> BinanceSpotRest.Endpoints.MarketData.TickerBookTicker.Endpoint.moduledoc()

  defstruct []

  defimpl BinanceSpotRest.Query do
    def validate(q), do: q

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.TickerBookTicker.Endpoint.metadata(),
        query: q
      }
  end
end
