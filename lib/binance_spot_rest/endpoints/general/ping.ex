defmodule BinanceSpotRest.Endpoints.General.Ping do
  @moduledoc """
  ### Test connectivity
  ```
  GET /api/v3/ping
  ```
  Test connectivity to the Rest API.

  **Weight:**
  1

  **Parameters:**
  NONE

  **Data Source:**
  Memory

  **Response:**
  ```
  {}
  ```
  """

  defstruct []

  defimpl BinanceSpotRest.Query do
    def validate(q), do: q

    def prepare(q),
      do: %BinanceSpotRest.RequestData{
        endpoint_data: %BinanceSpotRest.EndpointData{
          endpoint: "/api/v3/ping",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._NONE()
        },
        query: q
      }
  end
end
