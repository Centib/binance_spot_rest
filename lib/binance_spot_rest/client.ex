defmodule BinanceSpotRest.Client do
  @moduledoc """
  Low-level BinanceSpotRest REST client (internal/advanced use).

  This module builds and executes HTTP requests based on a `RequestSpec`.

  ## Overview

  The client handles:

    * Constructing the full request URL
    * Adding required headers
    * Signing requests for endpoints that require authentication
    * Making the HTTP request via `Req`

  **Note:** This module is intended for advanced users who need fine-grained control.
  For most use cases, you should use `BinanceSpotRest.request/1` instead.

  ## Options (`opts`)

  All functions accept optional keyword list:

    * `:base_url` - Base API URL (default: `BinanceSpotRest.Env.base_url()`)
    * `:headers` - List of headers (default: built from `security_type`)
    * `:secret_key_fn` - Function returning secret key (default: `BinanceSpotRest.Env.secret_key()`)
    * `:timestamp_fn` - Function returning current timestamp (default: `BinanceSpotRest.Client.Timestamp.create()`)
    * `:signature_fn` - Function that creates signature (default: `BinanceSpotRest.Client.Signature.create()`)

  ## Example

      alias BinanceSpotRest.Endpoints.Trading.OrderPost.LimitQuery

      query = %LimitQuery{...}

      request =
        BinanceSpotRest.Client.create_request(query,
          base_url: "https://mock.url",
          timestamp_fn: fn -> 1_740_000_000_000 end,
          signature_fn: fn _qs, _key -> "mock-signature" end
        )

      {:ok, response} = BinanceSpotRest.Client.make_request(request)

  """

  import BinanceSpotRest.Client.Security
  import BinanceSpotRest.Client.Methods

  @type opts :: [
          base_url: String.t(),
          headers: [{String.t(), String.t()}],
          secret_key_fn: (-> String.t()),
          timestamp_fn: (-> integer()),
          signature_fn: (String.t(), String.t() -> String.t())
        ]

  def create_request(
        %BinanceSpotRest.Query.RequestSpec{
          metadata: %BinanceSpotRest.Query.EndpointMetadata{
            endpoint: endpoint,
            method: method,
            security_type: security_type
          },
          query: query
        },
        opts \\ []
      )
      when is_method(method) and is_security_type(security_type) do
    base_url = Keyword.get(opts, :base_url, BinanceSpotRest.Env.base_url())
    headers = Keyword.get(opts, :headers, BinanceSpotRest.Client.Headers.build(security_type))
    secret_key_fn = Keyword.get(opts, :secret_key_fn, &BinanceSpotRest.Env.secret_key/0)
    timestamp_fn = Keyword.get(opts, :timestamp_fn, &BinanceSpotRest.Client.Timestamp.create/0)
    signature_fn = Keyword.get(opts, :signature_fn, &BinanceSpotRest.Client.Signature.create/2)

    %BinanceSpotRest.Client.Request{
      method: method,
      headers: headers,
      base_url: base_url,
      url:
        BinanceSpotRest.Client.Url.build(
          query,
          endpoint,
          security_type,
          secret_key_fn,
          timestamp_fn,
          signature_fn
        )
    }
  end

  def make_request(%BinanceSpotRest.Client.Request{} = r) do
    request = Req.new(method: r.method, headers: r.headers, base_url: r.base_url, url: r.url)
    Req.request(request)
  end
end
