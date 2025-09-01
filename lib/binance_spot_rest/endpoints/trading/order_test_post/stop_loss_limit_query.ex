defmodule BinanceSpotRest.Endpoints.Trading.OrderTestPost.StopLossLimitQuery do
  @moduledoc """
             Order Test (post) - Stop loss limit query

             """ <> BinanceSpotRest.Endpoints.Trading.OrderTestPost.Endpoint.moduledoc()

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
