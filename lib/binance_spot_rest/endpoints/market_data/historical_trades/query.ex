defmodule BinanceSpotRest.Endpoints.MarketData.HistoricalTrades.Query do
  @moduledoc """
  ### Old trade lookup

  ```
  GET /api/v3/historicalTrades
  ```

  Get older trades.

  **Weight:**
  25

  **Parameters:**

  | Name   | Type   | Mandatory | Description                                             |
  | ------ | ------ | --------- | ------------------------------------------------------- |
  | symbol | STRING | YES       |                                                         |
  | limit  | INT    | NO        | Default 500; max 1000.                                  |
  | fromId | LONG   | NO        | TradeId to fetch from. Default gets most recent trades. |

  **Data Source:**
  Database

  **Response:**

  ```
  [
    {
      "id": 28457,
      "price": "4.00000100",
      "qty": "12.00000000",
      "quoteQty": "48.000012",
      "time": 1499865549590,
      "isBuyerMaker": true,
      "isBestMatch": true
    }
  ]
  ```
  """

  defstruct [:symbol, :fromId, :limit]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.maybe_integer_in_range(:limit, %{min: 1, max: 1000})
        |> Valpa.maybe_integer(:fromId)

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/historicalTrades",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._NONE()
        },
        query: q
      }
  end
end
