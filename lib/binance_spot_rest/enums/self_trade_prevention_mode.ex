defmodule BinanceSpotRest.Enums.SelfTradePreventionMode do
  @moduledoc """
  Defines self-trade prevention modes for Binance Spot orders.

  This enum corresponds to the `selfTradePreventionMode` parameter in the
  [Binance API – New Order (TRADE)](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#new-order-trade).

  Supported values:

    * `:NONE` – No self-trade prevention is applied.
    * `:EXPIRE_MAKER` – If a new order would match an existing order from the same account, the **maker order** is canceled.
    * `:EXPIRE_TAKER` – If a new order would match an existing order from the same account, the **taker order** is canceled.
    * `:EXPIRE_BOTH` – If a new order would match an existing order from the same account, **both orders are canceled**.

  More info: [Self Trade Prevention (STP) FAQ](https://github.com/binance/binance-spot-api-docs/blob/master/faqs/stp_faq.md)
  """
  use Numa, [
    :NONE,
    :EXPIRE_MAKER,
    :EXPIRE_TAKER,
    :EXPIRE_BOTH
  ]
end
