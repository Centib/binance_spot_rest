defmodule BinanceSpotRest.Endpoints.Trading.OrderTestPost.LimitMakerQuery do
  @moduledoc """
             Order Test (post) - Limit maker query

             """ <> BinanceSpotRest.Endpoints.Trading.OrderTestPost.Endpoint.moduledoc()

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker.fields() ++
              BinanceSpotRest.Endpoints.Trading.OrderTestPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker.validation()
        |> BinanceSpotRest.Endpoints.Trading.OrderTestPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderTestPost.Endpoint.metadata(),
        query: q
      }
  end
end
