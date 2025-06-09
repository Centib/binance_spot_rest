defmodule BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.Endpoint do
  @moduledoc """
   ### New Order list - OCO (TRADE)

  ```
  POST /api/v3/orderList/oco
  ```

  Send in an one-cancels-the-other (OCO) pair, where activation of one order immediately cancels the other.

  - An OCO has 2 orders called the **above order** and **below order**.
  - One of the orders must be a `LIMIT_MAKER/TAKE_PROFIT/TAKE_PROFIT_LIMIT` order and the other must be `STOP_LOSS` or `STOP_LOSS_LIMIT` order.
  - Price restrictions
  - If the OCO is on the `SELL` side:
    - `LIMIT_MAKER/TAKE_PROFIT_LIMIT` `price` > Last Traded Price > `STOP_LOSS/STOP_LOSS_LIMIT` `stopPrice`
    - `TAKE_PROFIT stopPrice` > Last Traded Price > `STOP_LOSS/STOP_LOSS_LIMIT stopPrice`
  - If the OCO is on the `BUY` side:
    - `LIMIT_MAKER/TAKE_PROFIT_LIMIT price` < Last Traded Price < `stopPrice`
    - `TAKE_PROFIT stopPrice` < Last Traded Price < `STOP_LOSS/STOP_LOSS_LIMIT stopPrice`
  - OCOs add **2 orders** to the unfilled order count, `EXCHANGE_MAX_ORDERS` filter, and the `MAX_NUM_ORDERS` filter.

  **Weight:**
  1

  **Data Source:**
  Matching Engine

  Full docs: [Binance API – orderList/oco POST](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#new-order-list---oco-trade)
  """

  def metadata do
    %BinanceSpotRest.Query.EndpointMetadata{
      endpoint: "/api/v3/orderList/oco",
      method: BinanceSpotRest.Enums.Method._post(),
      security_type: BinanceSpotRest.Enums.SecurityType._TRADE()
    }
  end
end
