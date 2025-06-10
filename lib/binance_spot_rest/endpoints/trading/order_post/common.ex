defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.Common do
  @moduledoc false

  def fields do
    [
      :newClientOrderId,
      :strategyId,
      :strategyType,
      :selfTradePreventionMode,
      :newOrderRespType,
      :recvWindow
    ]
  end

  def validation(q, remap \\ &Function.identity/1) do
    q
    |> Valpa.maybe_string(remap.(:newClientOrderId))
    |> Valpa.maybe_integer(remap.(:strategyId))
    |> Valpa.maybe_integer_in_range(remap.(:strategyType), %{min: 1_000_000, max: :infinity})
    |> Valpa.maybe_value_of_values(
      remap.(:selfTradePreventionMode),
      BinanceSpotRest.Enums.SelfTradePreventionMode.values()
    )
    |> Valpa.maybe_value_of_values(
      remap.(:newOrderRespType),
      BinanceSpotRest.Enums.NewOrderRespType.values()
    )
    |> Valpa.maybe_integer_in_range(remap.(:recvWindow), %{min: 0, max: 60_000})
  end
end
