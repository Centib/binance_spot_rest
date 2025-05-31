defmodule BinanceSpotRest.Endpoints.MarketData.TickerBookTicker.Query do
  @moduledoc """
  Empty query
  """

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
