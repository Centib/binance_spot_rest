defmodule BinanceSpotRest.Client.Request do
  @moduledoc """
  Low-level request struct (internal/advanced use).

  This struct represents an HTTP request built by `BinanceSpotRest.Client`.

  ## Fields

    * `:method` - HTTP method (`:get`, `:post`, etc.)
    * `:headers` - List of request headers (`[{String.t(), String.t()}]`)
    * `:base_url` - Base URL for the request (e.g., `"https://api.binance.com"`)
    * `:url` - Full request URL including path and query parameters

  **Note:** This struct is typically constructed via `BinanceSpotRest.Client.create_request/2`.
  Direct usage is intended for advanced users or testing purposes.
  """

  @enforce_keys [:method, :headers, :base_url, :url]
  defstruct [:method, :headers, :base_url, :url]
end
