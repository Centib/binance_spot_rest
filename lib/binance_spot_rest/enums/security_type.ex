defmodule BinanceSpotRest.Enums.SecurityType do
  @moduledoc """
  Defines the security type required for Binance Spot REST API endpoints.

  This enum corresponds to the `securityType` field in the
  [Binance API – General API Information](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#general-api-information).

  Security type specifies what kind of authentication is needed
  when calling an endpoint.

  Supported values:

    * `:NONE` – No authentication required.
      Example: public market data endpoints.

    * `:TRADE` – Endpoint requires an API key and a signed payload.
      Used for creating and managing orders.

    * `:USER_DATA` – Endpoint requires an API key and a signed payload.
      Used for account information, balances, and order history.

    * `:USER_STREAM` – Endpoint requires an API key.
      Used for starting and managing user data streams (WebSocket listen keys).
  """
  use Numa, [:NONE, :TRADE, :USER_DATA, :USER_STREAM]
end
