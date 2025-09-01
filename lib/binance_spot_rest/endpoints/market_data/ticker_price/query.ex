defmodule BinanceSpotRest.Endpoints.MarketData.TickerPrice.Query do
  @moduledoc """
             Ticker Price - Empty query

             """ <> BinanceSpotRest.Endpoints.MarketData.TickerPrice.Endpoint.moduledoc()

  defstruct []

  defimpl BinanceSpotRest.Query do
    def validate(q), do: q

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.TickerPrice.Endpoint.metadata(),
        query: q
      }
  end
end
