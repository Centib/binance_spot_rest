defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.StopLossQuery do
  @moduledoc """
             Order (post) - Stop loss query

             """ <> BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.moduledoc()

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLoss.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLoss.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
