defmodule BinanceSpotRest.Endpoints.Trading.OrderTestPost.StopLossQuery do
  @moduledoc """
             Order Test (post) - Stop loss query

             """ <> BinanceSpotRest.Endpoints.Trading.OrderTestPost.Endpoint.moduledoc()

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLoss.fields() ++
              BinanceSpotRest.Endpoints.Trading.OrderTestPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLoss.validation()
        |> BinanceSpotRest.Endpoints.Trading.OrderTestPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderTestPost.Endpoint.metadata(),
        query: q
      }
  end
end
