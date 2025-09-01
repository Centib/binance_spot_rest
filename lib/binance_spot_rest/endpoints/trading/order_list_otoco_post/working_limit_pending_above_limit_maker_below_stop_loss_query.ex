defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.WorkingLimitPendingAboveLimitMakerBelowStopLossQuery do
  @moduledoc """
             Order List Otoco (post) - Working limit pending above limit maker pending below stop loss query

             """ <> BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.Endpoint.moduledoc()

  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Limit, as: Working
  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker, as: PendingAbove
  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLoss, as: PendingBelow

  defstruct BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.UseShared.fields(
              Working,
              PendingAbove,
              PendingBelow,
              pendingSide: BinanceSpotRest.Enums.Side._SELL()
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
        |> Valpa.value_of_values(:pendingSide, [BinanceSpotRest.Enums.Side._SELL()])
        |> BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.Common.validation()
        |> Valpa.map_compare_decimal_keys({:>, :pendingAbovePrice, :pendingBelowStopPrice})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.Endpoint.metadata(),
        query: q
      }
  end
end
