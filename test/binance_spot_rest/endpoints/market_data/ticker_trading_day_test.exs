defmodule BinanceSpotRest.Endpoints.MarketData.TickerTradingDayTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.MarketData.TickerTradingDay

  describe "request" do
    test "symbol" do
      assert {:ok, request} =
               %TickerTradingDay.SymbolQuery{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request()

      assert request == %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://testnet.binance.vision",
               url: "/api/v3/ticker/tradingDay?symbol=BTCUSDT"
             }
    end

    test "symbols" do
      assert {:ok, request} =
               %TickerTradingDay.SymbolsQuery{
                 symbols: ["BTCUSDT", "BNBBTC"],
                 timeZone: "-1:00",
                 type: BinanceSpotRest.Enums.Type._MINI()
               }
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request()

      assert request == %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://testnet.binance.vision",
               url:
                 "/api/v3/ticker/tradingDay?symbols=%5B%22BTCUSDT%22%2C%22BNBBTC%22%5D&timeZone=-1%3A00&type=MINI"
             }
    end
  end

  describe "validation" do
    test "invalid without symbol" do
      assert {:error, _} =
               %TickerTradingDay.SymbolQuery{symbol: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerTradingDay.SymbolQuery{type: BinanceSpotRest.Enums.Type._MINI()}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid without symbols" do
      assert {:error, _} =
               %TickerTradingDay.SymbolsQuery{symbols: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerTradingDay.SymbolsQuery{type: BinanceSpotRest.Enums.Type._MINI()}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid non-string symbol" do
      assert {:error, _} =
               %TickerTradingDay.SymbolQuery{symbol: :BTCUSDT}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid non-uniq-list-of-strings symbol" do
      assert {:error, _} =
               %TickerTradingDay.SymbolsQuery{symbols: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerTradingDay.SymbolsQuery{symbols: ["BTCUSDT", :BNBBTC]}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerTradingDay.SymbolsQuery{symbols: ["BTCUSDT", "BTCUSDT"]}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid timeZone" do
      assert {:error, _} =
               %TickerTradingDay.SymbolQuery{
                 symbol: "BTCUSDT",
                 timeZone: "-13:00"
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid type" do
      assert {:error, _} =
               %TickerTradingDay.SymbolQuery{
                 symbol: "BTCUSDT",
                 type: :INVALID
               }
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
