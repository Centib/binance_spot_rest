defmodule BinanceSpotRest.Endpoints.MarketData.TickerPriceTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.MarketData.TickerPrice

  describe "request" do
    test "symbol" do
      assert {:ok, request} =
               %TickerPrice.SymbolQuery{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/ticker/price?symbol=BTCUSDT"
             } == request
    end

    test "symbols" do
      assert {:ok, request} =
               %TickerPrice.SymbolsQuery{
                 symbols: ["BTCUSDT", "BNBBTC"]
               }
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/ticker/price?symbols=%5B%22BTCUSDT%22%2C%22BNBBTC%22%5D"
             } == request
    end

    test "empty" do
      assert {:ok, request} =
               %TickerPrice.Query{}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/ticker/price"
             } == request
    end
  end

  describe "validation" do
    test "invalid without symbol" do
      assert {:error, _} =
               %TickerPrice.SymbolQuery{symbol: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerPrice.SymbolQuery{}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid without symbols" do
      assert {:error, _} =
               %TickerPrice.SymbolsQuery{symbols: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerPrice.SymbolsQuery{symbols: []}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerPrice.SymbolsQuery{}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid non-string symbol" do
      assert {:error, _} =
               %TickerPrice.SymbolQuery{symbol: :BTCUSDT}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid non-uniq-list-of-strings symbol" do
      assert {:error, _} =
               %TickerPrice.SymbolsQuery{symbols: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerPrice.SymbolsQuery{symbols: ["BTCUSDT", :BNBBTC]}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %TickerPrice.SymbolsQuery{symbols: ["BTCUSDT", "BTCUSDT"]}
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
