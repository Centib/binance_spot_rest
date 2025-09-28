defmodule BinanceSpotRest.Endpoints.Account.MyPreventedMatches.Query do
  @moduledoc """
  My Prevented Matches

  ### Query Prevented Matches (USER_DATA)

  ```
  GET /api/v3/myPreventedMatches
  ```

  Displays the list of orders that were expired due to STP.

  These are the combinations supported:

  - `symbol` + `preventedMatchId`
  - `symbol` + `orderId`
  - `symbol` + `orderId` + `fromPreventedMatchId` (`limit` will default to 500)
  - `symbol` + `orderId` + `fromPreventedMatchId` + `limit`

  **Parameters:**

  | Name                 | Type   | Mandatory | Description                              |
  | -------------------- | ------ | --------- | ---------------------------------------- |
  | symbol               | STRING | YES       |                                          |
  | preventedMatchId     | LONG   | NO        |                                          |
  | orderId              | LONG   | NO        |                                          |
  | fromPreventedMatchId | LONG   | NO        |                                          |
  | limit                | INT    | NO        | Default: `500`; Maximum: `1000`          |
  | recvWindow           | DECIMAL | NO        | The value cannot be greater than `60000`. Supports up to three decimal places of precision (e.g., 6000.346) so that microseconds may be specified.  |
  | timestamp            | LONG   | YES       |                                          |

  **Weight:**

  | Case                           | Weight |
  | ------------------------------ | ------ |
  | If `symbol` is invalid         | 2      |
  | Querying by `preventedMatchId` | 2      |
  | Querying by `orderId`          | 20     |

  **Data Source:**

  Database

  **Response:**

  ```json
  [
    {
      "symbol": "BTCUSDT",
      "preventedMatchId": 1,
      "takerOrderId": 5,
      "makerSymbol": "BTCUSDT",
      "makerOrderId": 3,
      "tradeGroupId": 1,
      "selfTradePreventionMode": "EXPIRE_MAKER",
      "price": "1.100000",
      "makerPreventedQuantity": "1.300000",
      "transactTime": 1669101687094
    }
  ]
  ```
  """

  defstruct [:symbol, :preventedMatchId, :orderId, :fromPreventedMatchId, :limit, :recvWindow]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.maybe_integer(:preventedMatchId)
        |> Valpa.maybe_integer(:orderId)
        |> Valpa.maybe_integer(:fromPreventedMatchId)
        |> Valpa.map_exclusive_keys([:preventedMatchId, :orderId])
        |> Valpa.map_exclusive_optional_keys([:preventedMatchId, :fromPreventedMatchId])
        |> Valpa.map_exclusive_optional_keys([:preventedMatchId, :limit])
        |> Valpa.maybe_integer_in_range(:limit, %{min: 0, max: 1000})
        |> Valpa.maybe_integer_in_range(:recvWindow, %{min: 0, max: 60_000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/myPreventedMatches",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._USER_DATA()
        },
        query: q
      }
  end
end
