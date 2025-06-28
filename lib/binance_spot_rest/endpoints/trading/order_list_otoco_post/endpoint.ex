defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.Endpoint do
  @moduledoc """
  #### New Order list - OTOCO (TRADE)

  ```
  POST /api/v3/orderList/otoco
  ```

  Place an OTOCO.

  - An OTOCO (One-Triggers-One-Cancels-the-Other) is an order list comprised of 3 orders.
  - The first order is called the **working order** and must be `LIMIT` or `LIMIT_MAKER`. Initially, only the working order goes on the order book.
  - The behavior of the working order is the same as the [OTO](#new-order-list---oto-trade).
  - OTOCO has 2 pending orders (pending above and pending below), forming an OCO pair. The pending orders are only placed on the order book when the working order gets **fully filled**.
  - The rules of the pending above and pending below follow the same rules as the [Order list OCO](#new-order-list---oco-trade).
  - OTOCOs add **3 orders** to the `EXCHANGE_MAX_NUM_ORDERS` filter and `MAX_NUM_ORDERS` filter.

  **Weight:** 1

  **Unfilled Order Count:**
  3

  **Data Source:**

  Matching Engine

  Full docs: [Binance API – orderList/otoco POST](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#new-order-list---otoco-trade)
  """

  def metadata do
    %BinanceSpotRest.Query.EndpointMetadata{
      endpoint: "/api/v3/orderList/otoco",
      method: BinanceSpotRest.Enums.Method._post(),
      security_type: BinanceSpotRest.Enums.SecurityType._TRADE()
    }
  end
end
