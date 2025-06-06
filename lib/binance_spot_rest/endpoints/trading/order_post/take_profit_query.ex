defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.TakeProfitQuery do
  @moduledoc """
  Take profit query
  """

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfit.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfit.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
