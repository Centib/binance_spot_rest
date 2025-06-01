defmodule BinanceSpotRest.Endpoints.Trading.Order.Common do
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

  def validation(q) do
    q
    |> Valpa.maybe_string(:newClientOrderId)
    |> Valpa.maybe_integer(:strategyId)
    |> Valpa.maybe_integer_in_range(:strategyType, %{min: 1_000_000, max: :infinity})
    |> Valpa.maybe_value_of_values(
      :selfTradePreventionMode,
      BinanceSpotRest.Enums.SelfTradePreventionMode.values()
    )
    |> Valpa.maybe_value_of_values(
      :newOrderRespType,
      BinanceSpotRest.Enums.NewOrderRespType.values()
    )
    |> Valpa.maybe_integer_in_range(:recvWindow, %{min: 0, max: 60_000})
  end
end
