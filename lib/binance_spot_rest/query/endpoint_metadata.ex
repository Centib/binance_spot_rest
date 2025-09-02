defmodule BinanceSpotRest.Query.EndpointMetadata do
  @moduledoc """
  Endpoint metadata (internal/advanced use).

  This struct holds information about a specific Binance endpoint used by `RequestSpec`.

  ## Fields

    * `:endpoint` - API endpoint path (e.g., `"/api/v3/order"`)
    * `:method` - HTTP method (`:get`, `:post`, `:put`, etc.)
    * `:security_type` - Security type required for the endpoint (`:NONE`, `:TRADE`, `:USER_DATA`, etc.)

  **Note:** Used internally by `BinanceSpotRest.Query.RequestSpec` and `BinanceSpotRest.Client`.
  """

  @enforce_keys [:endpoint, :method, :security_type]
  defstruct [:endpoint, :method, :security_type]
end
