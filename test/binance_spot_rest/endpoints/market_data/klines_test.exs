defmodule BinanceSpotRest.Endpoints.MarketData.KlinesTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.MarketData.Klines

  describe "request" do
    test "symbol and interval" do
      assert {:ok, request} =
               %Klines.Query{symbol: "BTCUSDT", interval: :"3m"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/klines?interval=3m&symbol=BTCUSDT"
             } == request
    end

    test "symbol, limit and fromId" do
      assert {:ok, request} =
               %Klines.Query{
                 symbol: "BTCUSDT",
                 interval: :"3m",
                 startTime: 1_498_793_709_153,
                 endTime: 1_498_793_809_153,
                 timeZone: "-1:00",
                 limit: 150
               }
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [],
               base_url: "https://fake.binance.url",
               url:
                 "/api/v3/klines?endTime=1498793809153&interval=3m&limit=150&startTime=1498793709153&symbol=BTCUSDT&timeZone=-1%3A00"
             } == request
    end
  end

  describe "validation" do
    test "invalid without symbol" do
      assert {:error, _} =
               %Klines.Query{symbol: nil, interval: :"3m"}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %Klines.Query{interval: :"3m"}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid without interval" do
      assert {:error, _} =
               %Klines.Query{symbol: "BTCUSDT", interval: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %Klines.Query{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid non-integer startTime" do
      assert {:error, _} =
               %Klines.Query{
                 symbol: "BTCUSDT",
                 interval: :"3m",
                 startTime: "1_498_793_709_153",
                 endTime: 1_498_793_809_153,
                 timeZone: "-1:00",
                 limit: 150
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid value timeZone" do
      assert {:error, _} =
               %Klines.Query{
                 symbol: "BTCUSDT",
                 interval: :"3m",
                 startTime: 1_498_793_709_153,
                 endTime: 1_498_793_809_153,
                 timeZone: "-13:00",
                 limit: 150
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid value interval" do
      assert {:error, _} =
               %Klines.Query{
                 symbol: "BTCUSDT",
                 interval: :"11m",
                 startTime: 1_498_793_709_153,
                 endTime: 1_498_793_809_153,
                 timeZone: "-1:00",
                 limit: 150
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid range limit" do
      assert {:error, _} =
               %Klines.Query{
                 symbol: "BTCUSDT",
                 interval: :"3m",
                 startTime: 1_498_793_709_153,
                 endTime: 1_498_793_809_153,
                 timeZone: "-1:00",
                 limit: 1001
               }
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
