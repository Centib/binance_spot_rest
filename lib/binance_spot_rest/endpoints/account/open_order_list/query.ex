defmodule BinanceSpotRest.Endpoints.Account.OpenOrderList.Query do
  @moduledoc """
  Open Order List

  ### Query Open Order lists (USER_DATA)

  ```
  GET /api/v3/openOrderList
  ```

  **Weight:**
  6

  **Parameters:**

  | Name       | Type | Mandatory | Description                              |
  | ---------- | ---- | --------- | ---------------------------------------- |
  | recvWindow | DECIMAL | NO        | The value cannot be greater than `60000`. Supports up to three decimal places of precision (e.g., 6000.346) so that microseconds may be specified.  |
  | timestamp  | LONG | YES       |                                          |

  **Data Source:**
  Database

  **Response:**

  ```javascript
  [
    {
      "orderListId": 31,
      "contingencyType": "OCO",
      "listStatusType": "EXEC_STARTED",
      "listOrderStatus": "EXECUTING",
      "listClientOrderId": "wuB13fmulKj3YjdqWEcsnp",
      "transactionTime": 1565246080644,
      "symbol": "LTCBTC",
      "orders": [
        {
          "symbol": "LTCBTC",
          "orderId": 4,
          "clientOrderId": "r3EH2N76dHfLoSZWIUw1bT"
        },
        {
          "symbol": "LTCBTC",
          "orderId": 5,
          "clientOrderId": "Cv1SnyPD3qhqpbjpYEHbd2"
        }
      ]
    }
  ]
  ```
  """

  defstruct [:recvWindow]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.maybe_integer_in_range(:recvWindow, %{min: 0, max: 60_000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/openOrderList",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._USER_DATA()
        },
        query: q
      }
  end
end
