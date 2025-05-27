defmodule BinanceSpotRest.ClientTest do
  @moduledoc false
  use ExUnit.Case, async: true

  defmodule Fake do
    @moduledoc false
    def base_url, do: "https://api.base.url"
    def headers, do: [{"x-mock-header", "value"}]

    def signature, do: "signature"
    def timestamp, do: 1_748_335_378_328
    def secret_key, do: "FAKE_KEY"

    def signature_fn, do: fn _query_string, _secret_key -> signature() end
    def timestamp_fn, do: fn -> timestamp() end
    def secret_key_fn, do: fn -> secret_key() end

    defmodule Query do
      @moduledoc false
      defstruct [:foo]
    end
  end

  test "create_request/2 with no security signs nothing" do
    endpoint = "/api/test/endpoint"
    method = BinanceSpotRest.Enums.Method._get()
    security_type = BinanceSpotRest.Enums.SecurityType._NONE()
    query = %Fake.Query{foo: "bar"}
    headers = []
    base_url = Fake.base_url()

    request_spec = %BinanceSpotRest.Query.RequestSpec{
      metadata: %BinanceSpotRest.Query.EndpointMetadata{
        endpoint: endpoint,
        method: method,
        security_type: security_type
      },
      query: query
    }

    req =
      BinanceSpotRest.Client.create_request(request_spec,
        base_url: base_url,
        headers: headers
      )

    assert %BinanceSpotRest.Client.Request{
             base_url: base_url,
             headers: headers,
             method: method,
             url: "/api/test/endpoint?foo=bar"
           } == req
  end

  test "create_request/2 with signed security appends timestamp and signature" do
    endpoint = "/api/test/endpoint"
    method = BinanceSpotRest.Enums.Method._post()
    security_type = BinanceSpotRest.Enums.SecurityType._TRADE()
    query = %Fake.Query{foo: "bar"}
    headers = Fake.headers()
    base_url = Fake.base_url()

    request_spec = %BinanceSpotRest.Query.RequestSpec{
      metadata: %BinanceSpotRest.Query.EndpointMetadata{
        endpoint: endpoint,
        method: method,
        security_type: security_type
      },
      query: query
    }

    req =
      BinanceSpotRest.Client.create_request(request_spec,
        base_url: base_url,
        headers: headers,
        secret_key_fn: Fake.secret_key_fn(),
        timestamp_fn: Fake.timestamp_fn(),
        signature_fn: Fake.signature_fn()
      )

    assert %BinanceSpotRest.Client.Request{
             base_url: base_url,
             headers: headers,
             method: method,
             url:
               "/api/test/endpoint?foo=bar&timestamp=#{Fake.timestamp()}&signature=#{Fake.signature()}"
           } == req
  end
end
