defmodule BinanceSpotRest.Endpoints.MarketData.DepthTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.MarketData.Depth

  describe "request" do
    test "symbol" do
      assert {:ok, request} =
               %Depth.Query{symbol: "BTCUSDT"}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/depth?symbol=BTCUSDT"
             } == request
    end

    test "symbol and limit" do
      assert {:ok, request} =
               %Depth.Query{symbol: "BTCUSDT", limit: 150}
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(base_url: "https://fake.binance.url")

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [],
               base_url: "https://fake.binance.url",
               url: "/api/v3/depth?limit=150&symbol=BTCUSDT"
             } == request
    end
  end

  describe "validation" do
    test "invalid without symbol" do
      assert {:error, _} =
               %Depth.Query{symbol: nil}
               ~>> BinanceSpotRest.Query.validate()

      assert {:error, _} =
               %Depth.Query{}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid with non-string symbol" do
      assert {:error, _} =
               %Depth.Query{symbol: :BTCUSDT}
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid not in range limit" do
      assert {:error, _} =
               %Depth.Query{
                 symbol: "BTCUSDT",
                 limit: 5001
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "valid in range limit" do
      assert {:ok, _} =
               %Depth.Query{
                 symbol: "BTCUSDT",
                 limit: 5000
               }
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
