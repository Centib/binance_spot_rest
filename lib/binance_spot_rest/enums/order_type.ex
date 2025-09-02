defmodule BinanceSpotRest.Enums.OrderType do
  @moduledoc """
  Defines supported order types for the Binance Spot REST API.

  This enum corresponds to the `orderType` parameter in the
  [Binance API – New Order (TRADE)](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#new-order-trade).

  Supported values:

    * `:LIMIT` – Buy or sell at a specified price or better.
    * `:MARKET` – Buy or sell immediately at the best available market price.
    * `:STOP_LOSS` – Triggers a market order once the stop price is reached.
    * `:STOP_LOSS_LIMIT` – Triggers a limit order once the stop price is reached.
    * `:TAKE_PROFIT` – Triggers a market order once the take-profit price is reached.
    * `:TAKE_PROFIT_LIMIT` – Triggers a limit order once the take-profit price is reached.
    * `:LIMIT_MAKER` – A limit order that must be posted to the order book (maker only).
      If it would match immediately as a taker, it is rejected.
  """
  use Numa, [
    :LIMIT,
    :MARKET,
    :STOP_LOSS,
    :STOP_LOSS_LIMIT,
    :TAKE_PROFIT,
    :TAKE_PROFIT_LIMIT,
    :LIMIT_MAKER
  ]
end
