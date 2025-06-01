defmodule BinanceSpotRest.Endpoints.MarketData.TickerBookTickerTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.MarketData.TickerBookTicker

  describe "request" do
    test "symbol" do
      assert {:ok, request} =
               %TickerBookTicker.SymbolQuery{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request()

      assert %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://testnet.binance.vision",
               url: "/api/v3/ticker/bookTicker?symbol=BTCUSDT"
             } == request
    end

    test "symbols" do
      assert {:ok, request} =
               %TickerBookTicker.SymbolsQuery{
                 symbols: ["BTCUSDT", "BNBBTC"]
               }
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request()

      assert %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://testnet.binance.vision",
               url: "/api/v3/ticker/bookTicker?symbols=%5B%22BTCUSDT%22%2C%22BNBBTC%22%5D"
             } == request
    end

    test "empty" do
      assert {:ok, request} =
               %TickerBookTicker.Query{}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request()

      assert %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://testnet.binance.vision",
               url: "/api/v3/ticker/bookTicker"
             } == request
    end
  end

  describe "validation" do
    test "invalid without symbol" do
      assert {:error, _} =
               %TickerBookTicker.SymbolQuery{symbol: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerBookTicker.SymbolQuery{}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid without symbols" do
      assert {:error, _} =
               %TickerBookTicker.SymbolsQuery{symbols: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerBookTicker.SymbolsQuery{symbols: []}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerBookTicker.SymbolsQuery{}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid non-string symbol" do
      assert {:error, _} =
               %TickerBookTicker.SymbolQuery{symbol: :BTCUSDT}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid non-uniq-list-of-strings symbol" do
      assert {:error, _} =
               %TickerBookTicker.SymbolsQuery{symbols: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerBookTicker.SymbolsQuery{symbols: ["BTCUSDT", :BNBBTC]}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerBookTicker.SymbolsQuery{symbols: ["BTCUSDT", "BTCUSDT"]}
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
