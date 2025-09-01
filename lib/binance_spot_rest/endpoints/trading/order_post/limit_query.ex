defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.LimitQuery do
  @moduledoc """
             Order (post) - Limit query

             """ <> BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.moduledoc()

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Limit.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Limit.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
