defmodule BinanceSpotRest.Endpoints.MarketData.AvgPrice.Query do
  @moduledoc """
  ### Current average price

  ```
  GET /api/v3/avgPrice
  ```

  Current average price for a symbol.

  **Weight:**
  2

  **Parameters:**

  | Name   | Type   | Mandatory | Description |
  | ------ | ------ | --------- | ----------- |
  | symbol | STRING | YES       |             |

  **Data Source:**
  Memory

  **Response:**

  ```
  {
    "mins": 5,                    // Average price interval (in minutes)
    "price": "9.35751834",        // Average price
    "closeTime": 1694061154503    // Last trade time
  }
  ```
  """

  defstruct [:symbol]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do: q |> Valpa.string(:symbol)

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/avgPrice",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._NONE()
        },
        query: q
      }
  end
end
