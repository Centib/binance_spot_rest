defmodule BinanceSpotRest.Endpoints.Trading.OrderTestPost.TakeProfitLimitQuery do
  @moduledoc """
  Order test: take profit limit query
  """

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfitLimit.fields() ++
              BinanceSpotRest.Endpoints.Trading.OrderTestPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfitLimit.validation()
        |> BinanceSpotRest.Endpoints.Trading.OrderTestPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderTestPost.Endpoint.metadata(),
        query: q
      }
  end
end
