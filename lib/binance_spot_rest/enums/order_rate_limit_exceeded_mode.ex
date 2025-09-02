defmodule BinanceSpotRest.Enums.OrderRateLimitExceededMode do
  @moduledoc """
  Defines the behavior when an order rate limit is exceeded.

  This enum corresponds to the `orderRateLimitExceededMode` field
  in the [POST /api/v3/order/cancelReplace](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#cancel-an-existing-order-and-send-a-new-order-trade).

  Supported values:

    * `:DO_NOTHING` – No special action is taken when the rate limit is exceeded.
    * `:CANCEL_ONLY` – Account is restricted to **cancel-only mode**; new orders are not allowed,
      but existing open orders can still be canceled.
  """
  use Numa, [
    :DO_NOTHING,
    :CANCEL_ONLY
  ]
end
