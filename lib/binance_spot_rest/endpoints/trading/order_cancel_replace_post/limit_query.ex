defmodule BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.LimitQuery do
  @moduledoc """
  Order cancel replace: limit query
  """

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Limit.fields() ++
              BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Limit.validation()
        |> BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Endpoint.metadata(),
        query: q
      }
  end
end
