defmodule BinanceSpotRest.Endpoints.Account.MyAllocations.Query do
  @moduledoc """
  My Allocations

  ### Query Allocations (USER_DATA)

  ```
  GET /api/v3/myAllocations
  ```

  (Additional notes: `orderId` and `limit` combination is forbidden)

  Retrieves allocations resulting from SOR order placement.

  **Weight:**
  20

  **Parameters:**

  | Name             | Type   | Mandatory | Description                               |
  | ---------------- | ------ | --------- | ----------------------------------------- |
  | symbol           | STRING | Yes       |                                           |
  | startTime        | LONG   | No        |                                           |
  | endTime          | LONG   | No        |                                           |
  | fromAllocationId | INT    | No        |                                           |
  | limit            | INT    | No        | Default: 500; Maximum: 1000               |
  | orderId          | LONG   | No        |                                           |
  | recvWindow       | DECIMAL | NO        | The value cannot be greater than `60000`. Supports up to three decimal places of precision (e.g., 6000.346) so that microseconds may be specified.  |
  | timestamp        | LONG   | No        |                                           |

  Supported parameter combinations:

  | Parameters                                | Response                                             |
  | ----------------------------------------- | ---------------------------------------------------- |
  | `symbol`                                  | allocations from oldest to newest                    |
  | `symbol` + `startTime`                    | oldest allocations since `startTime`                 |
  | `symbol` + `endTime`                      | newest allocations until `endTime`                   |
  | `symbol` + `startTime` + `endTime`        | allocations within the time range                    |
  | `symbol` + `fromAllocationId`             | allocations by allocation ID                         |
  | `symbol` + `orderId`                      | allocations related to an order starting with oldest |
  | `symbol` + `orderId` + `fromAllocationId` | allocations related to an order by allocation ID     |

  **Note:** The time between `startTime` and `endTime` can't be longer than 24 hours.

  **Data Source:**
  Database

  **Response:**

  ```javascript
  [
    {
      "symbol": "BTCUSDT",
      "allocationId": 0,
      "allocationType": "SOR",
      "orderId": 1,
      "orderListId": -1,
      "price": "1.00000000",
      "qty": "5.00000000",
      "quoteQty": "5.00000000",
      "commission": "0.00000000",
      "commissionAsset": "BTC",
      "time": 1687506878118,
      "isBuyer": true,
      "isMaker": false,
      "isAllocator": false
    }
  ]
  ```
  """

  defstruct [:symbol, :startTime, :endTime, :fromAllocationId, :orderId, :limit, :recvWindow]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.maybe_integer(:startTime)
        |> Valpa.maybe_integer(:endTime)
        |> Valpa.maybe_integer(:fromAllocationId)
        |> Valpa.maybe_integer(:orderId)
        |> Valpa.map_exclusive_optional_keys([:orderId, :startTime])
        |> Valpa.map_exclusive_optional_keys([:orderId, :endTime])
        |> Valpa.map_exclusive_optional_keys([:fromAllocationId, :startTime])
        |> Valpa.map_exclusive_optional_keys([:fromAllocationId, :endTime])
        |> Valpa.map_exclusive_optional_keys([:orderId, :limit])
        |> Valpa.Custom.validator(BinanceSpotRest.Validators.StartTimeEndTimeRange24h)
        |> Valpa.maybe_integer_in_range(:limit, %{min: 0, max: 1000})
        |> Valpa.Custom.maybe_validator(:recvWindow, BinanceSpotRest.Validators.RecvWindow)

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/myAllocations",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._USER_DATA()
        },
        query: q
      }
  end
end
