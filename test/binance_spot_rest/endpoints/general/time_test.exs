defmodule BinanceSpotRest.Endpoints.General.TimeTest do
  @moduledoc false
  use ExUnit.Case, async: true
  import Loe

  test "time request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.Time.Query{}
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

    assert %BinanceSpotRest.Client.Request{
             method: BinanceSpotRest.Enums.Method._get(),
             headers: [],
             base_url: "https://fake.binance.url",
             url: "/api/v3/time"
           } == request
  end
end
