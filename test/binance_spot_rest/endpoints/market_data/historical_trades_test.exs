defmodule BinanceSpotRest.Endpoints.MarketData.HistoricalTradesTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.MarketData.HistoricalTrades

  describe "request" do
    test "symbol" do
      assert {:ok, request} =
               %HistoricalTrades.Query{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/historicalTrades?symbol=BTCUSDT"
             } == request
    end

    test "symbol, limit and fromId" do
      assert {:ok, request} =
               %HistoricalTrades.Query{symbol: "BTCUSDT", limit: 150, fromId: 28_457}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/historicalTrades?fromId=28457&limit=150&symbol=BTCUSDT"
             } == request
    end
  end

  describe "validation" do
    test "invalid without symbol" do
      assert {:error, _} =
               %HistoricalTrades.Query{symbol: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %HistoricalTrades.Query{}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid with non-string symbol" do
      assert {:error, _} =
               %HistoricalTrades.Query{symbol: :BTCUSDT}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid not in range limit" do
      assert {:error, _} =
               %HistoricalTrades.Query{
                 symbol: "BTCUSDT",
                 limit: 1001
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "valid in range limit" do
      assert {:ok, _} =
               %HistoricalTrades.Query{
                 symbol: "BTCUSDT",
                 limit: 1000
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid type fromId" do
      assert {:error, _} =
               %HistoricalTrades.Query{
                 symbol: "BTCUSDT",
                 fromId: "23456"
               }
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
