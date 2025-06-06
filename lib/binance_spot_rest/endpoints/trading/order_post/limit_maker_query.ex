defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.LimitMakerQuery do
  @moduledoc """
  Limit maker query
  """

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
