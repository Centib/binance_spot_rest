defmodule BinanceSpotRest.Enums.TimeInForce do
  @moduledoc """
  Defines the time-in-force options for Binance Spot orders.

  This enum corresponds to the `timeInForce` parameter in the
  [Binance API – New Order (TRADE)](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#new-order-trade).

  Supported values:

    * `:GTC` – Good Till Canceled. The order remains active on the book until it is canceled.
    * `:IOC` – Immediate Or Cancel. The order will attempt to fill as much as possible immediately, and any unfilled portion is canceled.
    * `:FOK` – Fill Or Kill. The order must be filled in its entirety immediately, or it is canceled.
  """

  use Numa, [:GTC, :IOC, :FOK]
end
