defmodule BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.AboveStopLossBelowLimitMakerQuery do
  @moduledoc """
  Order list oco: above stop loss below limit maker query
  """

  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLoss, as: Above
  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker, as: Below

  defstruct BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.UseShared.fields(Above, Below) ++
              BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.UseShared.validation(Above, Below)
        |> BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.Endpoint.metadata(),
        query: q
      }
  end
end
