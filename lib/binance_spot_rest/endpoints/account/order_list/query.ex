defmodule BinanceSpotRest.Endpoints.Account.OrderList.Query do
  @moduledoc """
  ### Query Order list (USER_DATA)

  ```
  GET /api/v3/orderList
  ```

  Retrieves a specific order list based on provided optional parameters.

  **Weight:**
  4

  **Parameters:**

  | Name              | Type   | Mandatory | Description                                                                                         |
  | ----------------- | ------ | --------- | --------------------------------------------------------------------------------------------------- |
  | orderListId       | LONG   | NO\*      | Query order list by `orderListId`. <br>`orderListId` or `origClientOrderId` must be provided.       |
  | origClientOrderId | STRING | NO\*      | Query order list by `listClientOrderId`. <br>`orderListId` or `origClientOrderId` must be provided. |
  | recvWindow        | LONG   | NO        | The value cannot be greater than `60000`                                                            |
  | timestamp         | LONG   | YES       |                                                                                                     |

  **Data Source:**
  Database

  **Response:**

  ```javascript
  {
    "orderListId": 27,
    "contingencyType": "OCO",
    "listStatusType": "EXEC_STARTED",
    "listOrderStatus": "EXECUTING",
    "listClientOrderId": "h2USkA5YQpaXHPIrkd96xE",
    "transactionTime": 1565245656253,
    "symbol": "LTCBTC",
    "orders": [
      {
        "symbol": "LTCBTC",
        "orderId": 4,
        "clientOrderId": "qD1gy3kc3Gx0rihm9Y3xwS"
      },
      {
        "symbol": "LTCBTC",
        "orderId": 5,
        "clientOrderId": "ARzZ9I00CPM8i3NhmU9Ega"
      }
    ]
  }
  ```
  """

  defstruct [:orderListId, :origClientOrderId, :recvWindow]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.maybe_integer(:orderListId)
        |> Valpa.maybe_string(:origClientOrderId)
        |> Valpa.map_inclusive_keys([:orderListId, :origClientOrderId])
        |> Valpa.maybe_integer_in_range(:recvWindow, %{min: 0, max: 60_000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/orderList",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._USER_DATA()
        },
        query: q
      }
  end
end
