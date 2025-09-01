defmodule BinanceSpotRest.Endpoints.Trading.OrderAmendKeepPriorityPut.Query do
  @moduledoc """
  Order Amend Keep Priority (put)

  ### Order Amend Keep Priority (TRADE)

  ```
  PUT /api/v3/order/amend/keepPriority
  ```

  Reduce the quantity of an existing open order.

  This adds 0 orders to the `EXCHANGE_MAX_ORDERS` filter and the `MAX_NUM_ORDERS` filter.

  Read [Order Amend Keep Priority FAQ](faqs/order_amend_keep_priority.md) to learn more.

  **Weight**:
  4

  **Unfilled Order Count:**
  0

  **Data Source**: Matching Engine

  Full docs: [Binance API – order/amend/keepPriority](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#order-amend-keep-priority-trade)
  """

  defstruct [:symbol, :newQty, :orderId, :origClientOrderId, :newClientOrderId, :recvWindow]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.decimal(:newQty)
        |> Valpa.map_inclusive_keys([:orderId, :origClientOrderId])
        |> Valpa.maybe_integer(:orderId)
        |> Valpa.maybe_string(:origClientOrderId)
        |> Valpa.maybe_string(:newClientOrderId)
        |> Valpa.maybe_integer_in_range(:recvWindow, %{min: 0, max: 60_000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/order/amend/keepPriority",
          method: BinanceSpotRest.Enums.Method._put(),
          security_type: BinanceSpotRest.Enums.SecurityType._TRADE()
        },
        query: q
      }
  end
end
