defmodule BinanceSpotRest.Endpoints.MarketData.TickerTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.MarketData.Ticker

  describe "request" do
    test "symbol" do
      assert {:ok, request} =
               %Ticker.SymbolQuery{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/ticker?symbol=BTCUSDT"
             } == request
    end

    test "symbols" do
      assert {:ok, request} =
               %Ticker.SymbolsQuery{
                 symbols: ["BTCUSDT", "BNBBTC"],
                 windowSize: BinanceSpotRest.Enums.WindowSize._15m(),
                 type: BinanceSpotRest.Enums.Type._MINI()
               }
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://fake.binance.url",
               url:
                 "/api/v3/ticker?symbols=%5B%22BTCUSDT%22%2C%22BNBBTC%22%5D&type=MINI&windowSize=15m"
             } == request
    end
  end

  describe "validation" do
    test "invalid without symbol" do
      assert {:error, _} =
               %Ticker.SymbolQuery{symbol: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %Ticker.SymbolQuery{type: BinanceSpotRest.Enums.Type._MINI()}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid without symbols" do
      assert {:error, _} =
               %Ticker.SymbolsQuery{symbols: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %Ticker.SymbolsQuery{type: BinanceSpotRest.Enums.Type._MINI()}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid non-string symbol" do
      assert {:error, _} =
               %Ticker.SymbolQuery{symbol: :BTCUSDT}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid non-uniq-list-of-strings symbol" do
      assert {:error, _} =
               %Ticker.SymbolsQuery{symbols: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %Ticker.SymbolsQuery{symbols: ["BTCUSDT", :BNBBTC]}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %Ticker.SymbolsQuery{symbols: ["BTCUSDT", "BTCUSDT"]}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid windowSize" do
      assert {:error, _} =
               %Ticker.SymbolQuery{
                 symbol: "BTCUSDT",
                 windowSize: "24h"
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid type" do
      assert {:error, _} =
               %Ticker.SymbolQuery{
                 symbol: "BTCUSDT",
                 type: :INVALID
               }
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
