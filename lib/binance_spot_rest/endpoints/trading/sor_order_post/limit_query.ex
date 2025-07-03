defmodule BinanceSpotRest.Endpoints.Trading.SorOrderPost.LimitQuery do
  @moduledoc """
  Sor order limit query
  """

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Limit.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Limit.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.SorOrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
