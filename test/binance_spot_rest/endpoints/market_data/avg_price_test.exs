defmodule BinanceSpotRest.Endpoints.MarketData.AvgPriceTest do
  @moduledoc false
  use ExUnit.Case, async: true
  import Loe

  describe "request" do
    test "valid" do
      assert {:ok, request} =
               %BinanceSpotRest.Endpoints.MarketData.AvgPrice.Query{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/avgPrice?symbol=BTCUSDT"
             } == request
    end
  end

  describe "validation" do
    test "invalid without symbol" do
      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.AvgPrice.Query{symbol: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.AvgPrice.Query{}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid with non-string symbol" do
      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.AvgPrice.Query{symbol: :BTCUSDT}
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
