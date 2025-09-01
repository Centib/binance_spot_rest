defmodule BinanceSpotRest.Endpoints.MarketData.Depth.Query do
  @moduledoc """
  Depth
  
  ### Order book

  ```
  GET /api/v3/depth
  ```

  **Weight:**
  Adjusted based on the limit:

  | Limit     | Request Weight |
  | --------- | -------------- |
  | 1-100     | 5              |
  | 101-500   | 25             |
  | 501-1000  | 50             |
  | 1001-5000 | 250            |

  **Parameters:**

  | Name   | Type   | Mandatory | Description                                                                            |
  | ------ | ------ | --------- | -------------------------------------------------------------------------------------- |
  | symbol | STRING | YES       |                                                                                        |
  | limit  | INT    | NO        | Default 100; max 5000. If limit > 5000 then the response will truncate to 5000.        |

  **Data Source:** Memory

  **Response:**

  ```
  {
    "lastUpdateId": 1027024,
    "bids": [
      [
        "4.00000000",     // PRICE
        "431.00000000"    // QTY
      ]
    ],
    "asks": [
      [
        "4.00000200",
        "12.00000000"
      ]
    ]
  }
  ```
  """

  defstruct [:symbol, :limit]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.maybe_integer_in_range(:limit, %{min: 1, max: 5000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/depth",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._NONE()
        },
        query: q
      }
  end
end
