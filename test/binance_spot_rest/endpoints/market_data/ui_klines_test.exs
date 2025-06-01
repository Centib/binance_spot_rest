defmodule BinanceSpotRest.Endpoints.MarketData.UiKlinesTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.MarketData.UiKlines

  describe "request" do
    test "symbol and interval" do
      assert {:ok, request} =
               %UiKlines.Query{symbol: "BTCUSDT", interval: :"3m"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request()

      assert %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://testnet.binance.vision",
               url: "/api/v3/uiKlines?interval=3m&symbol=BTCUSDT"
             } == request
    end

    test "symbol, limit and fromId" do
      assert {:ok, request} =
               %UiKlines.Query{
                 symbol: "BTCUSDT",
                 interval: :"3m",
                 startTime: 1_498_793_709_153,
                 endTime: 1_498_793_809_153,
                 timeZone: "-1:00",
                 limit: 150
               }
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request()

      assert %BinanceSpotRest.Client.Request{
               method: :get,
               headers: [],
               base_url: "https://testnet.binance.vision",
               url:
                 "/api/v3/uiKlines?endTime=1498793809153&interval=3m&limit=150&startTime=1498793709153&symbol=BTCUSDT&timeZone=-1%3A00"
             } == request
    end
  end

  describe "validation" do
    test "invalid without symbol" do
      assert {:error, _} =
               %UiKlines.Query{symbol: nil, interval: :"3m"}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %UiKlines.Query{interval: :"3m"}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid without interval" do
      assert {:error, _} =
               %UiKlines.Query{symbol: "BTCUSDT", interval: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %UiKlines.Query{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid non-integer startTime" do
      assert {:error, _} =
               %UiKlines.Query{
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
               %UiKlines.Query{
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
               %UiKlines.Query{
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
               %UiKlines.Query{
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
