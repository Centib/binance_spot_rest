defmodule BinanceSpotRest.Endpoints.MarketData.DepthTest do
  @moduledoc false
  use ExUnit.Case, async: true
  import Loe

  describe "request" do
    test "symbol" do
      assert {:ok, request} =
               %BinanceSpotRest.Endpoints.MarketData.Depth.Query{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request()

      assert request == %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://testnet.binance.vision",
               url: "/api/v3/depth?symbol=BTCUSDT"
             }
    end

    test "symbol and limit" do
      assert {:ok, request} =
               %BinanceSpotRest.Endpoints.MarketData.Depth.Query{symbol: "BTCUSDT", limit: 150}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request()

      assert request == %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://testnet.binance.vision",
               url: "/api/v3/depth?limit=150&symbol=BTCUSDT"
             }
    end
  end

  describe "validation" do
    test "invalid without symbol" do
      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.Depth.Query{symbol: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.Depth.Query{}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid with non-string symbol" do
      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.Depth.Query{symbol: :BTCUSDT}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid not in range limit" do
      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.Depth.Query{
                 symbol: "BTCUSDT",
                 limit: 5001
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "valid in range limit" do
      assert {:ok, _} =
               %BinanceSpotRest.Endpoints.MarketData.Depth.Query{
                 symbol: "BTCUSDT",
                 limit: 5000
               }
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
