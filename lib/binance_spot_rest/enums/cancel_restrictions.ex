defmodule BinanceSpotRest.Enums.CancelRestrictions do
  @moduledoc """
  Defines cancel restrictions for Binance Spot orders.

  This enum is used in the
  [Cancel order (TRADE)](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#cancel-order-trade)
  and
  [Cancel an Existing Order and Send a New Order (TRADE)](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#cancel-an-existing-order-and-send-a-new-order-trade)
  endpoints.

  Supported values:

    * `:ONLY_NEW` – Cancel will succeed only if the order status is `NEW`.
    * `:ONLY_PARTIALLY_FILLED` – Cancel will succeed only if the order status is `PARTIALLY_FILLED`.
      For more details, see [Regarding cancelRestrictions](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#regarding-cancelrestrictions).
  """
  use Numa, [
    :ONLY_NEW,
    :ONLY_PARTIALLY_FILLED
  ]
end
