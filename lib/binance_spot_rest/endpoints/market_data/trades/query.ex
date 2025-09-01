defmodule BinanceSpotRest.Endpoints.MarketData.Trades.Query do
  @moduledoc """
  Trades
  
  ### Recent trades list

  ```
  GET /api/v3/trades
  ```

  Get recent trades.

  **Weight:**
  25

  **Parameters:**

  | Name   | Type   | Mandatory | Description            |
  | ------ | ------ | --------- | ---------------------- |
  | symbol | STRING | YES       |                        |
  | limit  | INT    | NO        | Default 500; max 1000. |

  **Data Source:**
  Memory

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

  defstruct [:symbol, :limit]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.maybe_integer_in_range(:limit, %{min: 1, max: 1000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/trades",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._NONE()
        },
        query: q
      }
  end
end
