defmodule BinanceSpotRest.Endpoints.MarketData.AggTradesTest do
  @moduledoc false
  use ExUnit.Case, async: true
  import Loe

  describe "request" do
    test "agg_trades query" do
      assert {:ok, request} =
               %BinanceSpotRest.Endpoints.MarketData.AggTrades.Query{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request()

      assert request == %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://testnet.binance.vision",
               url: "/api/v3/aggTrades?symbol=BTCUSDT"
             }
    end
  end

  describe "validation" do
    test "valid with only fromId" do
      assert {:ok, _} =
               %BinanceSpotRest.Endpoints.MarketData.AggTrades.Query{
                 symbol: "BTCUSDT",
                 fromId: 123
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "valid with only startTime" do
      assert {:ok, _} =
               %BinanceSpotRest.Endpoints.MarketData.AggTrades.Query{
                 symbol: "BTCUSDT",
                 startTime: 1_700_000_000_000
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "valid with only endTime" do
      assert {:ok, _} =
               %BinanceSpotRest.Endpoints.MarketData.AggTrades.Query{
                 symbol: "BTCUSDT",
                 endTime: 1_700_000_000_000
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "valid with limit = 1000" do
      assert {:ok, _} =
               %BinanceSpotRest.Endpoints.MarketData.AggTrades.Query{
                 symbol: "BTCUSDT",
                 limit: 1000
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid with both fromId and startTime" do
      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.AggTrades.Query{
                 symbol: "BTCUSDT",
                 fromId: 123,
                 startTime: 1_700_000_000_000
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid with both fromId and endTime" do
      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.AggTrades.Query{
                 symbol: "BTCUSDT",
                 fromId: 123,
                 endTime: 1_700_000_000_000
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid with limit > 1000" do
      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.AggTrades.Query{
                 symbol: "BTCUSDT",
                 limit: 1001
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid with limit < 1" do
      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.AggTrades.Query{
                 symbol: "BTCUSDT",
                 limit: 0
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid without symbol" do
      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.AggTrades.Query{}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid with non-string symbol" do
      assert {:error, _} =
               %BinanceSpotRest.Endpoints.MarketData.AggTrades.Query{symbol: :BTCUSDT}
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
