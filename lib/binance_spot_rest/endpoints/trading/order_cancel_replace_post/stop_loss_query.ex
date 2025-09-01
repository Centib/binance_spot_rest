defmodule BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.StopLossQuery do
  @moduledoc """
             Order Cancel Replace (post) - Stop loss query
             
             """ <> BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Endpoint.moduledoc()

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLoss.fields() ++
              BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLoss.validation()
        |> BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Endpoint.metadata(),
        query: q
      }
  end
end
