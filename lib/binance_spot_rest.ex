defmodule BinanceSpotRest do
  @moduledoc """
  Entry point for making Binance Spot REST API requests.

  ## Overview

  This module provides a unified `request/2` function that handles:

  - Optional validation of endpoint-specific query structs
  - Preparing the HTTP request
  - Signing and executing the request (or returning it for inspection)

  You typically don’t need to call any other module directly — just build a query and pass it here.

  ## Usage

  1. Build a query struct for the desired endpoint.
  2. Pass it to `BinanceSpotRest.request/2`.
  3. Optionally configure behavior via options (validation, execution, headers, etc.).

  ### Example

  ```elixir
  alias BinanceSpotRest.Endpoints.Trading.OrderPost.LimitQuery

  query = %LimitQuery{
    symbol: "LTCBTC",
    side: BinanceSpotRest.Enums.Side._BUY(),
    type: BinanceSpotRest.Enums.OrderType._LIMIT(),
    timeInForce: BinanceSpotRest.Enums.TimeInForce._GTC(),
    quantity: Decimal.new("1.0"),
    price: Decimal.new("0.00029")
  }

  {:ok, result} = BinanceSpotRest.request(query)

  # With test overrides
  BinanceSpotRest.request(query,
    execute: false,
    base_url: "https://mock.url",
    timestamp_fn: fn -> 1_740_000_000_000 end,
    signature_fn: fn _query_string, _secret_key -> "mock-signature" end
  )
  ```

  ### Low-level API (optional)

  You can also use the lower-level functions directly:

  ```elixir
  import Loe
  alias BinanceSpotRest.Endpoints.Trading.OrderPost.LimitQuery

  query = %LimitQuery{
    symbol: "LTCBTC",
    side: BinanceSpotRest.Enums.Side._BUY(),
    type: BinanceSpotRest.Enums.OrderType._LIMIT(),
    timeInForce: BinanceSpotRest.Enums.TimeInForce._GTC(),
    quantity: Decimal.new("1.0"),
    price: Decimal.new("0.00029")
  }

  query
  ~>> BinanceSpotRest.Query.validate()
  ~>> BinanceSpotRest.Query.prepare()
  ~>> BinanceSpotRest.Client.create_request()
  ~>> BinanceSpotRest.Client.make_request()

  # With overrides, without validation, and without executing the request
  query
  ~>> BinanceSpotRest.Query.prepare()
  ~>> BinanceSpotRest.Client.create_request(
    base_url: "https://mock.url",
    headers: [{"FAKE_API_KEY", "fake_api_key"}],
    timestamp_fn: fn -> 1_740_000_000_000 end,
    signature_fn: fn _query_string, _secret_key -> "mock-signature" end
  )
  ```

  ## Endpoint Queries

  Each Binance endpoint has its own query module under:

  ```
  BinanceSpotRest.Endpoints.<Category>.<EndpointPath>.<QueryModule>
  ```

  Where `<EndpointPath>` is derived from the endpoint path and HTTP method:

  - Example 1:

    - Endpoint: `/api/v3/ticker/bookTicker`
    - Method: `GET`
    - Module path: `TickerBookTicker` (method suffix omitted for GET)

  - Example 2:

    - Endpoint: `/api/v3/order/amend/keepPriority`
    - Method: `PUT`
    - Module path: `OrderAmendKeepPriorityPut` (HTTP method suffix added)

  All query structs follow a consistent pattern and include field validation.

  ## See Also

  - `BinanceSpotRest.request/2` — Main function for triggering a request
  - `BinanceSpotRest.Client` — low-level client and request builder

  """

  import Loe

  @type opts :: [
          validate: boolean(),
          execute: boolean(),
          base_url: String.t(),
          headers: [{String.t(), String.t()}],
          secret_key_fn: (-> String.t()),
          timestamp_fn: (-> integer()),
          signature_fn: (String.t(), String.t() -> String.t())
        ]
  @spec request(struct()) :: {:error, any()} | {:ok, any()}
  @spec request(struct(), opts) :: {:ok, any()} | {:error, any()}
  @doc """
  Processes a query struct into a request and optionally validates or sends it.

  ## Options

  This function accepts both internal control options and options that affect the underlying HTTP request.

  ### Control Options

    - `:validate` (boolean, default: `true`) — whether to validate the query struct before preparing the request.
    - `:execute` (boolean, default: `true`) — whether to actually execute the HTTP request or just return the request struct.

  ### Client Options

  These options are forwarded to `BinanceSpotRest.Client.create_request/2` and affect how the HTTP request is constructed:

    - `:base_url` (`String.t()`) — override the default Binance base URL (useful for testing or mocking).
    - `:headers` (`[{String.t(), String.t()}]`) — additional or replacement HTTP headers.
    - `:secret_key_fn` (`(() -> String.t())`) — a function that returns the Binance secret key.
    - `:timestamp_fn` (`(() -> integer())`) — a function that returns a timestamp (used in signed endpoints).
    - `:signature_fn` (`(String.t(), String.t() -> String.t())`) — a function to compute the request signature.

  ## Examples

      BinanceSpotRest.request(query)

      BinanceSpotRest.request(query, validate: false)

      BinanceSpotRest.request(query, execute: false)

      BinanceSpotRest.request(query, validate: false, execute: false)

      BinanceSpotRest.request(query,
        base_url: "https://test.binance.local",
        headers: [{"X-MOCK", "true"}],
        timestamp_fn: fn -> 1_740_000_000_000 end,
        signature_fn: fn _data, _key -> "mock-signature" end,
        execute: false
      )

  Returns either:

    - `{:ok, response}` if successful (or if `execute: false`, the request struct)
    - `{:error, reason}` if validation, preparation, or request execution fails
  """
  def request(q, opts \\ []) do
    opts =
      Keyword.validate!(
        opts,
        [
          :base_url,
          :headers,
          :secret_key_fn,
          :timestamp_fn,
          :signature_fn,
          validate: true,
          execute: true
        ]
      )

    {validate, opts} = Keyword.pop(opts, :validate, true)
    {execute, opts} = Keyword.pop(opts, :execute, true)

    q
    ~>> maybe_validate(validate)
    ~>> BinanceSpotRest.Query.prepare()
    ~>> BinanceSpotRest.Client.create_request(opts)
    ~>> maybe_make_request(execute)
  end

  defp maybe_validate(q, true), do: q ~>> BinanceSpotRest.Query.validate()
  defp maybe_validate(q, false), do: q

  defp maybe_make_request(r, true), do: r ~>> BinanceSpotRest.Client.make_request()
  defp maybe_make_request(r, false), do: r
end
