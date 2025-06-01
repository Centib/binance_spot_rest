defmodule BinanceSpotRest.Endpoints.General.PingTest do
  @moduledoc false
  use ExUnit.Case, async: true
  import Loe

  test "ping request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.Ping.Query{}
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

    assert %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://fake.binance.url",
             url: "/api/v3/ping"
           } == request
  end
end
