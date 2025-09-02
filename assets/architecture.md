# Architecture

This page describes the **low-level workflow** of the `BinanceSpotRest` library.
Intended for advanced users, contributors, or testing purposes.

## 1. Query Structs

Every endpoint is represented by a **query struct**, e.g.:

```elixir
%BinanceSpotRest.Endpoints.General.Time.Query{}
```

These structs may have parameters depending on the endpoint. They are the starting point
for building requests.

## 2. Validation

Before sending, a query should be validated using the `BinanceSpotRest.Query` protocol:

```elixir
import Loe

query = %BinanceSpotRest.Endpoints.General.Time.Query{}
{:ok, validated_query} = query ~>> BinanceSpotRest.Query.validate()
```

* Returns `{:ok, query}` if valid
* Returns `{:error, reason}` if invalid

## 3. Preparation

Prepare the query for execution using `prepare/1`:

```elixir
{:ok, request_spec} = validated_query ~>> BinanceSpotRest.Query.prepare()
```

* Produces a `%BinanceSpotRest.Query.RequestSpec{}` struct containing:

  * `metadata` → `%BinanceSpotRest.Query.EndpointMetadata{}`

    * `endpoint` — API path (string)
    * `method` — HTTP method (`:get`, `:post`, etc.)
    * `security_type` — endpoint security (`:NONE`, `:TRADE`, etc.)
  * `query` → original query struct

## 4. Client Request

Build and execute the HTTP request using `BinanceSpotRest.Client`:

```elixir
request = BinanceSpotRest.Client.create_request(request_spec)
{:ok, response} = BinanceSpotRest.Client.make_request(request)
```

* `create_request/2` builds `%BinanceSpotRest.Client.Request{}`
* `make_request/1` executes the HTTP request via `Req`
* Optional keyword arguments allow mocking for testing:

```elixir
request = BinanceSpotRest.Client.create_request(request_spec,
  base_url: "https://mock.url",
  headers: [{"FAKE_API_KEY", "fake_api_key"}],
  timestamp_fn: fn -> 1_740_000_000_000 end,
  signature_fn: fn _qs, _key -> "mock-signature" end
)
```

## 5. Workflow Diagram

```
      ┌───────────────────────────────┐
      │        Query Struct           │
      │  %BinanceSpotRest.Endpoints.* │
      └──────────────┬────────────────┘
                     │ validate()
                     ▼
      ┌───────────────────────────────┐
      │    Validated Query Struct     │
      └──────────────┬────────────────┘
                     │ prepare()
                     ▼
┌────────────────────────────────────────────┐
│           RequestSpec Struct               │
│    %BinanceSpotRest.Query.RequestSpec      │
│        metadata + original query           │
└────────────────────┬───────────────────────┘
                     │ create_request(opts \\ [])
                     │ # optional overrides:
                     │ # base_url, headers,
                     │ # timestamp_fn, signature_fn
                     ▼
     ┌──────────────────────────────────┐
     │    Client Request Struct         │
     │ %BinanceSpotRest.Client.Request  │
     └───────────────┬──────────────────┘
                     │ make_request()
                     ▼
        ┌───────────────────────────┐
        │        HTTP Response      │
        └───────────────────────────┘
```

## Notes

* This workflow is **optional**; for most use cases, simply call:

```elixir
{:ok, result} = BinanceSpotRest.request(query)
```

* Internal modules like `RequestSpec`, `EndpointMetadata`, `Client.Timestamp`, and `Client.Signature`
  are used automatically.
* Direct low-level use is intended for **testing, mocking, or advanced contributions**.