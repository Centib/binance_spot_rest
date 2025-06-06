defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.TakeProfitLimitQuery do
  @moduledoc """
  Take profit limit query
  """

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfitLimit.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfitLimit.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
