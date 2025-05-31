defmodule BinanceSpotRest.Endpoints.General.Time.Query do
  @moduledoc """
  ### Check server time
  ```
  GET /api/v3/time
  ```
  Test connectivity to the Rest API and get the current server time.

  **Weight:**
  1

  **Parameters:**
  NONE

  **Data Source:**
  Memory

  **Response:**
  ```
  {
    "serverTime": 1499827319559
  }
  ```
  """

  defstruct []

  defimpl BinanceSpotRest.Query do
    def validate(q), do: q

    def prepare(q) do
      %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/time",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._NONE()
        },
        query: q
      }
    end
  end
end
