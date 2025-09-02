defmodule BinanceSpotRest.Enums.CancelReplaceMode do
  @moduledoc """
  Defines cancel-replace modes for Binance Spot orders.

  This enum corresponds to the `cancelReplaceMode` parameter in the
  [Binance API – Cancel an Existing Order and Send a New Order (TRADE)](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#cancel-an-existing-order-and-send-a-new-order-trade).

  Supported values:

    * `:STOP_ON_FAILURE` – If the cancel request fails, the new order placement will not be attempted.
    * `:ALLOW_FAILURE` – The new order placement will be attempted even if the cancel request fails.
  """
  use Numa, [
    :STOP_ON_FAILURE,
    :ALLOW_FAILURE
  ]
end
