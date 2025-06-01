defmodule BinanceSpotRest.Endpoints.MarketData.TradesTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.MarketData.Trades

  describe "request" do
    test "symbol" do
      assert {:ok, request} =
               %Trades.Query{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/trades?symbol=BTCUSDT"
             } == request
    end

    test "symbol and limit" do
      assert {:ok, request} =
               %Trades.Query{symbol: "BTCUSDT", limit: 150}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/trades?limit=150&symbol=BTCUSDT"
             } == request
    end
  end

  describe "validation" do
    test "invalid without symbol" do
      assert {:error, _} =
               %Trades.Query{symbol: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %Trades.Query{}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid with non-string symbol" do
      assert {:error, _} =
               %Trades.Query{symbol: :BTCUSDT}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid not in range limit" do
      assert {:error, _} =
               %Trades.Query{
                 symbol: "BTCUSDT",
                 limit: 1001
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "valid in range limit" do
      assert {:ok, _} =
               %Trades.Query{
                 symbol: "BTCUSDT",
                 limit: 1000
               }
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
