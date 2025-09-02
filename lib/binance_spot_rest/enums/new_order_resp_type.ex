defmodule BinanceSpotRest.Enums.NewOrderRespType do
  @moduledoc """
  Defines the response type for new order requests.

  This enum corresponds to the `newOrderRespType` parameter in the
  [Binance API – New Order (TRADE)](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#new-order-trade).

  Supported values:

    * `:ACK` – Order accepted and immediately acknowledged. Only `orderId` is returned.
    * `:RESULT` – Order accepted and result is returned, including order details such as symbol, order type, side, etc.
    * `:FULL` – Order accepted and full order information is returned, including fills.
  """
  use Numa, [:ACK, :RESULT, :FULL]
end
