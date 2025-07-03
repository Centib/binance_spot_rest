defmodule BinanceSpotRest.Endpoints.Trading.SorOrderPost.Endpoint do
  @moduledoc """
  #### New order using SOR (TRADE)

  (
    This endpoint is not tested online because of:

    The Smart Order Routing (SOR) feature is not available on the Binance Spot Testnet.
    While Binance's Spot Testnet does offer a way to test trading functionalities using their API,
    it focuses on standard order types like market, limit, stop-limit, and OCO orders.
    SOR, an experimental feature, is specifically available on the mainnet for certain trading pairs
    and is not enabled on the testnet environment.
  )

  ```
  POST /api/v3/sor/order
  ```
  Places an order using smart order routing (SOR).

  This adds 1 order to the `EXCHANGE_MAX_ORDERS` filter and the `MAX_NUM_ORDERS` filter.

  Read [SOR FAQ](https://github.com/binance/binance-spot-api-docs/blob/master/faqs/sor_faq.md) to learn more.

  **Weight:**
  1

  **Unfilled Order Count:**
  1

  **Note:** `POST /api/v3/sor/order` only supports `LIMIT` and `MARKET` orders. `quoteOrderQty` is not supported.

  **Data Source:**
  Matching Engine

  Full docs: [Binance API – sor/order POST](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#new-order-using-sor-trade)
  """

  def metadata do
    %BinanceSpotRest.Query.EndpointMetadata{
      endpoint: "/api/v3/sor/order",
      method: BinanceSpotRest.Enums.Method._post(),
      security_type: BinanceSpotRest.Enums.SecurityType._TRADE()
    }
  end
end
