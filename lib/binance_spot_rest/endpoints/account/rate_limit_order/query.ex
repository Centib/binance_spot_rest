defmodule BinanceSpotRest.Endpoints.Account.RateLimitOrder.Query do
  @moduledoc """
  Rate Limit Order

  ### Query Unfilled Order Count (USER_DATA)

  ```
  GET /api/v3/rateLimit/order
  ```

  Displays the user's unfilled order count for all intervals.

  **Weight:**
  40

  **Parameters:**

  | Name       | Type | Mandatory | Description                              |
  | ---------- | ---- | --------- | ---------------------------------------- |
  | recvWindow | DECIMAL | NO        | The value cannot be greater than `60000`. Supports up to three decimal places of precision (e.g., 6000.346) so that microseconds may be specified.  |
  | timestamp  | LONG | YES       |                                          |

  **Data Source:**
  Memory

  **Response:**

  ```json
  [
    {
      "rateLimitType": "ORDERS",
      "interval": "SECOND",
      "intervalNum": 10,
      "limit": 50,
      "count": 0
    },
    {
      "rateLimitType": "ORDERS",
      "interval": "DAY",
      "intervalNum": 1,
      "limit": 160000,
      "count": 0
    }
  ]
  ```
  """

  defstruct [:recvWindow]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.Custom.maybe_validator(:recvWindow, BinanceSpotRest.Validators.RecvWindow)

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/rateLimit/order",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._USER_DATA()
        },
        query: q
      }
  end
end
