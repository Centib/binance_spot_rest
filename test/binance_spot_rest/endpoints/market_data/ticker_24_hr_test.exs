defmodule BinanceSpotRest.Endpoints.MarketData.Ticker24HrTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.MarketData.Ticker24Hr

  describe "request" do
    test "symbol" do
      assert {:ok, request} =
               %Ticker24Hr.SymbolQuery{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/ticker/24hr?symbol=BTCUSDT"
             } == request
    end

    test "symbols" do
      assert {:ok, request} =
               %Ticker24Hr.SymbolsQuery{
                 symbols: ["BTCUSDT", "BNBBTC"],
                 type: BinanceSpotRest.Enums.Type._MINI()
               }
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/ticker/24hr?symbols=%5B%22BTCUSDT%22%2C%22BNBBTC%22%5D&type=MINI"
             } == request
    end

    test "empty" do
      assert {:ok, request} =
               %Ticker24Hr.Query_DANGER_LARGE_WEIGHT{}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/ticker/24hr"
             } == request
    end
  end

  describe "validation" do
    test "invalid without symbol" do
      assert {:error, _} =
               %Ticker24Hr.SymbolQuery{symbol: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %Ticker24Hr.SymbolQuery{type: BinanceSpotRest.Enums.Type._MINI()}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid without symbols" do
      assert {:error, _} =
               %Ticker24Hr.SymbolsQuery{symbols: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %Ticker24Hr.SymbolsQuery{type: BinanceSpotRest.Enums.Type._MINI()}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid non-string symbol" do
      assert {:error, _} =
               %Ticker24Hr.SymbolQuery{symbol: :BTCUSDT}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid non-uniq-list-of-strings symbol" do
      assert {:error, _} =
               %Ticker24Hr.SymbolsQuery{symbols: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %Ticker24Hr.SymbolsQuery{symbols: ["BTCUSDT", :BNBBTC]}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %Ticker24Hr.SymbolsQuery{symbols: ["BTCUSDT", "BTCUSDT"]}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid type" do
      assert {:error, _} =
               %Ticker24Hr.SymbolQuery{
                 symbol: "BTCUSDT",
                 type: :INVALID
               }
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
