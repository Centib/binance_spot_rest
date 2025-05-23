defmodule BinanceSpotRest.Endpoints.General.TimeTest do
  @moduledoc false
  use ExUnit.Case, async: true
  import Loe

  test "time request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.Time.Query{}
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request()

    assert request == %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://testnet.binance.vision",
             url: "/api/v3/time"
           }
  end
end
