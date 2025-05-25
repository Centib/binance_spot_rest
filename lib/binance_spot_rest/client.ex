defmodule BinanceSpotRest.Client do
  @moduledoc """
  BinanceSpotRest REST client.

  Builds HTTP requests based on `RequestSpec` input.
  """

  import BinanceSpotRest.Client.Security
  import BinanceSpotRest.Client.Methods

  @type opt ::
          {:base_url, String.t()}
          | {:headers, [{String.t(), String.t()}]}
          | {:secret_key, String.t()}
          | {:timestamp, integer()}

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
    secret_key = Keyword.get(opts, :secret_key, nil)
    timestamp = Keyword.get(opts, :timestamp, nil)

    %BinanceSpotRest.Client.Request{
      method: method,
      headers: headers,
      base_url: base_url,
      url: BinanceSpotRest.Client.Url.build(query, endpoint, security_type, secret_key, timestamp)
    }
  end

  def make_request(%BinanceSpotRest.Client.Request{} = r) do
    request = Req.new(method: r.method, headers: r.headers, base_url: r.base_url, url: r.url)
    Req.request(request)
  end
end
