# Architecture Guide

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

## 4. Build Request

Turn the `RequestSpec` into a client request using `BinanceSpotRest.Client.create_request/2`:

```elixir
request = BinanceSpotRest.Client.create_request(request_spec)
```

* Produces `%BinanceSpotRest.Client.Request{}`
* Accepts optional overrides for **testing or mocking**:

```elixir
request = BinanceSpotRest.Client.create_request(request_spec,
  base_url: "https://mock.url",
  headers: [{"FAKE_API_KEY", "fake_api_key"}],
  timestamp_fn: fn -> 1_740_000_000_000 end,
  signature_fn: fn _qs, _key -> "mock-signature" end
)
```

## 5. Make Request

Execute the built client request using `make_request/1`:

```elixir
{:ok, response} = BinanceSpotRest.Client.make_request(request)
```

* Sends the request via `Req`
* Returns `{:ok, response}` or `{:error, reason}`

## Workflow Diagram

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
                     ▼
     ┌──────────────────────────────────┐
     │    Client Request Struct         │
     │  %BinanceSpotRest.Client.Request │
     └───────────────┬──────────────────┘
                     │ make_request()
                     ▼
        ┌───────────────────────────┐
        │        HTTP Response      │
        └───────────────────────────┘
```

## Pipeline

For convenience, the entire flow can be expressed as a pipeline using `Loe`.

(The diagram above shows the step-by-step flow; the pipeline below demonstrates the same process in practice.)

```
import Loe

%BinanceSpotRest.Endpoints.General.Time.Query{}
~>> BinanceSpotRest.Query.validate()
~>> BinanceSpotRest.Query.prepare()
~>> BinanceSpotRest.Client.create_request()
~>> BinanceSpotRest.Client.make_request()
# => {:ok, response} or {:error, reason}
```

## Notes

* This workflow is **optional**; for most use cases, simply call:

```elixir
{:ok, result} = BinanceSpotRest.request(query)
```

* Internal modules like `RequestSpec`, `EndpointMetadata`, `Client.Timestamp`, and `Client.Signature`
  are used automatically.
* Direct low-level use is intended for **testing, mocking, or advanced contributions**.