defmodule BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.TakeProfitLimitQuery do
  @moduledoc """
             Order Cancel Replace (post) - Take profit limit query
             
             """ <> BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Endpoint.moduledoc()

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfitLimit.fields() ++
              BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfitLimit.validation()
        |> BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Endpoint.metadata(),
        query: q
      }
  end
end
