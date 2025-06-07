defmodule BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.LimitMakerQuery do
  @moduledoc """
  Order cancel replace: limit maker order
  """

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker.fields() ++
              BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker.validation()
        |> BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Endpoint.metadata(),
        query: q
      }
  end
end
