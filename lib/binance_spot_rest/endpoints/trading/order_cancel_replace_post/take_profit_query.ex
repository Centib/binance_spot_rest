defmodule BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.TakeProfitQuery do
  @moduledoc """
             Order Cancel Replace (post) - Take profit query
             
             """ <> BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Endpoint.moduledoc()

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfit.fields() ++
              BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfit.validation()
        |> BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Endpoint.metadata(),
        query: q
      }
  end
end
