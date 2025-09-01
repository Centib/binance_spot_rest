defmodule BinanceSpotRest.Endpoints.Account.AllOrderList.Query do
  @moduledoc """
  All Order List

  ### Query all Order lists (USER_DATA)

  ```
  GET /api/v3/allOrderList
  ```

  Retrieves all order lists based on provided optional parameters.

  Note that the time between `startTime` and `endTime` can't be longer than 24 hours.

  **Weight:**
  20

  **Parameters:**

  | Name       | Type | Mandatory | Description                                                   |
  | ---------- | ---- | --------- | ------------------------------------------------------------- |
  | fromId     | LONG | NO        | If supplied, neither `startTime` or `endTime` can be provided |
  | startTime  | LONG | NO        |                                                               |
  | endTime    | LONG | NO        |                                                               |
  | limit      | INT  | NO        | Default: 500; Maximum: 1000                                   |
  | recvWindow | LONG | NO        | The value cannot be greater than `60000`                      |
  | timestamp  | LONG | YES       |                                                               |

  **Data Source:**
  Database

  **Response:**

  ```javascript
  [
    {
      "orderListId": 29,
      "contingencyType": "OCO",
      "listStatusType": "EXEC_STARTED",
      "listOrderStatus": "EXECUTING",
      "listClientOrderId": "amEEAXryFzFwYF1FeRpUoZ",
      "transactionTime": 1565245913483,
      "symbol": "LTCBTC",
      "orders": [
        {
          "symbol": "LTCBTC",
          "orderId": 4,
          "clientOrderId": "oD7aesZqjEGlZrbtRpy5zB"
        },
        {
          "symbol": "LTCBTC",
          "orderId": 5,
          "clientOrderId": "Jr1h6xirOxgeJOUuYQS7V3"
        }
      ]
    },
    {
      "orderListId": 28,
      "contingencyType": "OCO",
      "listStatusType": "EXEC_STARTED",
      "listOrderStatus": "EXECUTING",
      "listClientOrderId": "hG7hFNxJV6cZy3Ze4AUT4d",
      "transactionTime": 1565245913407,
      "symbol": "LTCBTC",
      "orders": [
        {
          "symbol": "LTCBTC",
          "orderId": 2,
          "clientOrderId": "j6lFOfbmFMRjTYA7rRJ0LP"
        },
        {
          "symbol": "LTCBTC",
          "orderId": 3,
          "clientOrderId": "z0KCjOdditiLS5ekAFtK81"
        }
      ]
    }
  ]
  ```
  """

  defstruct [:fromId, :startTime, :endTime, :limit, :recvWindow]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.maybe_integer(:fromId)
        |> Valpa.maybe_integer(:startTime)
        |> Valpa.maybe_integer(:endTime)
        |> Valpa.map_exclusive_optional_keys([:fromId, :startTime])
        |> Valpa.map_exclusive_optional_keys([:fromId, :endTime])
        |> Valpa.Custom.validator(BinanceSpotRest.Validators.StartTimeEndTimeRange24h)
        |> Valpa.maybe_integer_in_range(:limit, %{min: 0, max: 1000})
        |> Valpa.maybe_integer_in_range(:recvWindow, %{min: 0, max: 60_000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/allOrderList",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._USER_DATA()
        },
        query: q
      }
  end
end
