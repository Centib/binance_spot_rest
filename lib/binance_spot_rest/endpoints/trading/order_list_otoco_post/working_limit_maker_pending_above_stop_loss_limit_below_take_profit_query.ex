defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.WorkingLimitMakerPendingAboveStopLossLimitBelowTakeProfitQuery do
  @moduledoc """
  Order list otoco: working limit maker pending above stop loss limit below take profit query
  """

  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker, as: Working
  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLossLimit, as: PendingAbove
  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfit, as: PendingBelow

  defstruct BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.UseShared.fields(
              Working,
              PendingAbove,
              PendingBelow,
              pendingSide: BinanceSpotRest.Enums.Side._BUY()
            ) ++ BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.UseShared.validation(
          Working,
          PendingAbove,
          PendingBelow
        )
        |> Valpa.value_of_values(:pendingSide, [BinanceSpotRest.Enums.Side._BUY()])
        |> BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.Common.validation()
        |> Valpa.map_compare_decimal_keys({:>, :pendingAboveStopPrice, :pendingBelowStopPrice})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.Endpoint.metadata(),
        query: q
      }
  end
end
