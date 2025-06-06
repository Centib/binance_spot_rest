defmodule BinanceSpotRest.Endpoints.Trading.OrderTestPost.StopLossLimitQuery do
  @moduledoc """
  Order test: stop loss limit query
  """

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLossLimit.fields() ++
              BinanceSpotRest.Endpoints.Trading.OrderTestPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLossLimit.validation()
        |> BinanceSpotRest.Endpoints.Trading.OrderTestPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderTestPost.Endpoint.metadata(),
        query: q
      }
  end
end
