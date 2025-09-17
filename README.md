# Binance Spot Rest

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)
[![Hex.pm](https://img.shields.io/hexpm/v/binance_spot_rest.svg)](https://hex.pm/packages/binance_spot_rest)
[![Documentation](https://img.shields.io/badge/docs-hexdocs-purple.svg)](https://hexdocs.pm/binance_spot_rest)

Elixir library for interacting with the **Binance Spot REST API**.
Provides a unified entry point for building, validating, signing, and executing REST requests.

## Features

* **Up-to-date with Binance Spot REST API** — Implements all current Spot endpoints according to [official docs](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md).
* **Polymorphic query struct interface** — Every endpoint is represented by a query struct. Whether it has parameters or not, you always call `BinanceSpotRest.request/1`.
* **Built-in validation** — Queries with parameters are validated before sending, preventing mistakes and unnecessary API calls.
* **Enum helpers** — Use provided Enums to safely build queries consistently.
* **Testable and mockable** — Easily override execution, base URL, timestamps, or signature functions for testing without hitting Binance servers.

- Built on top of [`Req`](https://hex.pm/packages/req) and [`Decimal`](https://hex.pm/packages/decimal)
- Uses [`Valpa`](https://hex.pm/packages/valpa), [`Loe`](https://hex.pm/packages/loe), and [`Numa`](https://hex.pm/packages/numa) internally for validation and composition

## Installation

Add to your `mix.exs`:

```elixir
def deps do
  [
    {:binance_spot_rest, "~> 0.1.3"}
  ]
end
```

Then fetch deps:

```bash
mix deps.get
```

## Configuration

The library reads credentials from your application configuration under `:binance_spot_rest`.

### Direct configuration

```elixir
import Config

config :binance_spot_rest,
  base_url: "https://testnet.binance.vision",  # or "https://api.binance.com" for production
  api_key: "your_api_key",
  secret_key: "your_secret_key"
```

> **Security tip:** Do not commit real API keys to your repository.

### Environment variables (optional, recommended)

```elixir
import Config

config :binance_spot_rest,
  base_url: System.get_env("BINANCE_SPOT_REST_BASE_URL"),
  api_key: System.get_env("BINANCE_SPOT_REST_API_KEY"),
  secret_key: System.get_env("BINANCE_SPOT_REST_SECRET_KEY")
```

Then set your credentials in your environment:

```bash
# Linux/macOS
export BINANCE_SPOT_REST_API_KEY="your_real_api_key"
export BINANCE_SPOT_REST_SECRET_KEY="your_real_secret_key"
export BINANCE_SPOT_REST_BASE_URL="https://api.binance.com"   # optional

# Windows (PowerShell)
setx BINANCE_SPOT_REST_API_KEY "your_real_api_key"
setx BINANCE_SPOT_REST_SECRET_KEY "your_real_secret_key"
setx BINANCE_SPOT_REST_BASE_URL "https://api.binance.com"
```

This keeps credentials out of code and version control.

### Validation Behavior

BinanceSpotRest uses [Valpa](https://hexdocs.pm/valpa/) for query parameter validation.

- **Default behavior in v0.1.1:**

  - In `:dev` and `:test` environments, validation errors include full stacktraces.
  - In `:prod`, stacktraces are **hidden**; only the error tuple is returned.
    This prevents leaking internal details in production logs.

- **Optional configuration:**
  You can override the default stacktrace behavior by configuring Valpa directly:

```elixir
import Config

config :valpa, show_stacktrace: true  # or false
```

## Usage

### High-level API

All endpoints are represented as **query structs**. You call them the same way, regardless of whether they have parameters:

```elixir
# Parameterized query
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

# Empty query (e.g., ping or time endpoints)
query = %BinanceSpotRest.Endpoints.General.Time.Query{}
{:ok, result} = BinanceSpotRest.request(query)
```

Override behavior for testing:

```elixir
BinanceSpotRest.request(query,
  execute: false,
  base_url: "https://mock.url",
  timestamp_fn: fn -> 1_740_000_000_000 end,
  signature_fn: fn _qs, _key -> "mock-signature" end
)
```

> **Tip for testing:** Use `execute: false` and a mock `signature_fn` to run tests without hitting Binance.

### Low-level API (optional)

You can chain internal steps manually:

```elixir
import Loe
alias BinanceSpotRest.Endpoints.Trading.OrderPost.LimitQuery

query = %LimitQuery{...}

query
~>> BinanceSpotRest.Query.validate()
~>> BinanceSpotRest.Query.prepare()
~>> BinanceSpotRest.Client.create_request()
~>> BinanceSpotRest.Client.make_request()
```

With overrides:

```elixir
query
~>> BinanceSpotRest.Query.prepare()
~>> BinanceSpotRest.Client.create_request(
  base_url: "https://mock.url",
  headers: [{"FAKE_API_KEY", "fake_api_key"}],
  timestamp_fn: fn -> 1_740_000_000_000 end,
  signature_fn: fn _qs, _key -> "mock-signature" end
)
```

For a detailed low-level workflow and pipeline examples, see the [Architecture Guide](https://hexdocs.pm/binance_spot_rest/architecture.html).

## Endpoint Queries

Each endpoint has its own query struct module:

```
BinanceSpotRest.Endpoints.<Category>.<EndpointPath>.<QueryModule>
```

Examples:

* `/api/v3/ticker/bookTicker` (`GET`) → `BinanceSpotRest.Endpoints.MarketData.TickerBookTicker`
* `/api/v3/order/amend/keepPriority` (`PUT`) → `BinanceSpotRest.Endpoints.Trading.OrderAmendKeepPriorityPut`

## Development / Updating

This library aims to stay aligned with the **official Binance Spot REST API**.

1. **Monitor official docs:** [Binance REST API](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md)
2. **Compare endpoints:** Look for new endpoints, changed parameters, or removed endpoints.
3. **Update query structs:** Add new endpoints or adjust parameters/validation using `Valpa`.
4. **Update enums:** Adjust Enum modules to reflect new or changed values.
5. **Test thoroughly:** Use the testnet to verify requests and responses.
6. **Document version:** Optionally indicate the library version or date it is synced with Binance API.

> **Tip for contributors:** Each PR updating endpoints should reference the official API section it implements or fixes.

## Adding a New Endpoint

Contributors can add new endpoints by creating a query struct under the proper module namespace.  
The library is designed to be polymorphic — any query struct works with `BinanceSpotRest.request/1`.  
Please refer to existing endpoint modules for examples.

## Documentation

Full docs: [HexDocs](https://hexdocs.pm/binance_spot_rest)

## Contributing

Contributions are welcome via issues or pull requests.
Created and maintained by [Centib](https://github.com/Centib).

## License

Released under the [MIT License](LICENSE.md)
