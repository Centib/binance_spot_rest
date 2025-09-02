defmodule BinanceSpotRest.Enums.Side do
  @moduledoc """
  Defines order sides for Binance Spot orders.

  This enum corresponds to the `side` parameter in the
  [Binance API – New Order (TRADE)](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#new-order-trade).

  Supported values:

    * `:BUY` – Place a buy order.
    * `:SELL` – Place a sell order.
  """
  use Numa, [:BUY, :SELL]
end
