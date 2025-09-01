defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.MarketQuery do
  @moduledoc """
             Order (post) - Market query

             """ <> BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.moduledoc()

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Market.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Market.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
