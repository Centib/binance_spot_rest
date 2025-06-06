defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.StopLossLimitQuery do
  @moduledoc """
  Stop loss limit query
  """

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLossLimit.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLossLimit.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
