defmodule BinanceSpotRest.Client do
  @moduledoc """
  Client
  """

  @st_none BinanceSpotRest.Enums.SecurityType._NONE()

  def create_request(%BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: endpoint,
          method: method,
          security_type: @st_none
        },
        query: %{__struct__: _} = q
      })
      when map_size(q) == 1 do
    %BinanceSpotRest.Client.Request{
      method: method,
      headers: [],
      base_url: BinanceSpotRest.Env.base_url(),
      url: endpoint
    }
  end

  def create_request(%BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: endpoint,
          method: method,
          security_type: @st_none
        },
        query: %{__struct__: _} = q
      }) do
    %BinanceSpotRest.Client.Request{
      method: method,
      headers: [],
      base_url: BinanceSpotRest.Env.base_url(),
      url:
        q
        |> BinanceSpotRest.Client.QueryString.create()
        |> BinanceSpotRest.Client.Url.create(endpoint)
    }
  end

  def make_request(%BinanceSpotRest.Client.Request{} = r) do
    request = Req.new(method: r.method, headers: r.headers, base_url: r.base_url, url: r.url)
    Req.request(request)
  end
end
