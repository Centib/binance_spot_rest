defmodule BinanceSpotRest.Endpoints.Account.MyTrades.Query do
  @moduledoc """
  My Trades

  ### Account trade list (USER_DATA)

  ```
  GET /api/v3/myTrades
  ```

  Get trades for a specific account and symbol.

  **Weight:**

  | Condition       | Weight |
  | --------------- | ------ |
  | Without orderId | 20     |
  | With orderId    | 5      |

  **Parameters:**

  | Name       | Type   | Mandatory | Description                                             |
  | ---------- | ------ | --------- | ------------------------------------------------------- |
  | symbol     | STRING | YES       |
  | orderId    | LONG   | NO        | This can only be used in combination with `symbol`.     |
  | startTime  | LONG   | NO        |
  | endTime    | LONG   | NO        |
  | fromId     | LONG   | NO        | TradeId to fetch from. Default gets most recent trades. |
  | limit      | INT    | NO        | Default: 500; Maximum: 1000.                            |
  | recvWindow | LONG   | NO        | The value cannot be greater than `60000`                |
  | timestamp  | LONG   | YES       |

  **Notes:**

  - If `fromId` is set, it will get trades >= that `fromId`.
  Otherwise most recent trades are returned.
  - The time between `startTime` and `endTime` can't be longer than 24 hours.
  - These are the supported combinations of all parameters:
  - `symbol`
  - `symbol` + `orderId`
  - `symbol` + `startTime`
  - `symbol` + `endTime`
  - `symbol` + `fromId`
  - `symbol` + `startTime` + `endTime`
  - `symbol`+ `orderId` + `fromId`

  **Data Source:**
  Memory => Database

  **Response:**

  ```javascript
  [
    {
      "symbol": "BNBBTC",
      "id": 28457,
      "orderId": 100234,
      "orderListId": -1,
      "price": "4.00000100",
      "qty": "12.00000000",
      "quoteQty": "48.000012",
      "commission": "10.10000000",
      "commissionAsset": "BNB",
      "time": 1499865549590,
      "isBuyer": true,
      "isMaker": false,
      "isBestMatch": true
    }
  ]
  ```
  """

  defstruct [:symbol, :orderId, :startTime, :endTime, :fromId, :limit, :recvWindow]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.maybe_integer(:orderId)
        |> Valpa.maybe_integer(:startTime)
        |> Valpa.maybe_integer(:endTime)
        |> Valpa.maybe_integer(:fromId)
        |> Valpa.map_exclusive_optional_keys([:orderId, :startTime])
        |> Valpa.map_exclusive_optional_keys([:orderId, :endTime])
        |> Valpa.map_exclusive_optional_keys([:fromId, :startTime])
        |> Valpa.map_exclusive_optional_keys([:fromId, :endTime])
        |> Valpa.Custom.validator(BinanceSpotRest.Validators.StartTimeEndTimeRange24h)
        |> Valpa.maybe_integer_in_range(:limit, %{min: 0, max: 1000})
        |> Valpa.maybe_integer_in_range(:recvWindow, %{min: 0, max: 60_000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/myTrades",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._USER_DATA()
        },
        query: q
      }
  end
end
