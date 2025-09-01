defmodule BinanceSpotRest.Endpoints.Account.Order.Query do
  @moduledoc """
  Order
  
  ### Query order (USER_DATA)

  ```
  GET /api/v3/order
  ```

  Check an order's status.

  **Weight:**
  4

  **Parameters:**

  | Name              | Type   | Mandatory | Description                              |
  | ----------------- | ------ | --------- | ---------------------------------------- |
  | symbol            | STRING | YES       |                                          |
  | orderId           | LONG   | NO        |                                          |
  | origClientOrderId | STRING | NO        |                                          |
  | recvWindow        | LONG   | NO        | The value cannot be greater than `60000` |
  | timestamp         | LONG   | YES       |                                          |

  **Notes:**

  - Either `orderId` or `origClientOrderId` must be sent.
  - If both `orderId` and `origClientOrderId` are provided, the `orderId` is searched first, then the `origClientOrderId` from that result is checked against that order. If both conditions are not met the request will be rejected.
  - For some historical orders `cummulativeQuoteQty` will be < 0, meaning the data is not available at this time.

  **Data Source:**
  Memory => Database

  **Response:**

  ```javascript
  {
    "symbol": "LTCBTC",
    "orderId": 1,
    "orderListId": -1,                 // This field will always have a value of -1 if not an order list.
    "clientOrderId": "myOrder1",
    "price": "0.1",
    "origQty": "1.0",
    "executedQty": "0.0",
    "cummulativeQuoteQty": "0.0",
    "status": "NEW",
    "timeInForce": "GTC",
    "type": "LIMIT",
    "side": "BUY",
    "stopPrice": "0.0",
    "icebergQty": "0.0",
    "time": 1499827319559,
    "updateTime": 1499827319559,
    "isWorking": true,
    "workingTime":1499827319559,
    "origQuoteOrderQty": "0.000000",
    "selfTradePreventionMode": "NONE"
  }
  ```

  **Note:** The payload above does not show all fields that can appear. Please refer to [Conditional fields in Order Responses](#conditional-fields-in-order-responses).
  """

  defstruct [:symbol, :orderId, :origClientOrderId, :recvWindow]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.maybe_integer(:orderId)
        |> Valpa.maybe_string(:origClientOrderId)
        |> Valpa.map_inclusive_keys([:orderId, :origClientOrderId])
        |> Valpa.maybe_integer_in_range(:recvWindow, %{min: 0, max: 60_000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/order",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._USER_DATA()
        },
        query: q
      }
  end
end
