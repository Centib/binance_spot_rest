defmodule BinanceSpotRest.Endpoints.General.ExchangeInfoTest do
  @moduledoc false
  use ExUnit.Case, async: true
  import Loe

  test "exchange_info symbol query request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.ExchangeInfo.SymbolQuery{symbol: "BNBBTC"}
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request()

    assert %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://testnet.binance.vision",
             url: "/api/v3/exchangeInfo?symbol=BNBBTC"
           } == request
  end

  test "exchange_info symbol and show permission sets query request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.ExchangeInfo.SymbolQuery{
               symbol: "BNBBTC",
               showPermissionSets: false
             }
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request()

    assert %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://testnet.binance.vision",
             url: "/api/v3/exchangeInfo?showPermissionSets=false&symbol=BNBBTC"
           } == request
  end

  test "exchange_info symbols query request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.ExchangeInfo.SymbolsQuery{
               symbols: ["BTCUSDT", "BNBBTC"]
             }
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request()

    assert %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://testnet.binance.vision",
             url: "/api/v3/exchangeInfo?symbols=%5B%22BTCUSDT%22%2C%22BNBBTC%22%5D"
           } == request
  end

  test "exchange_info symbols and show permission sets query sets request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.ExchangeInfo.SymbolsQuery{
               symbols: ["BTCUSDT", "BNBBTC"],
               showPermissionSets: false
             }
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request()

    assert %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://testnet.binance.vision",
             url:
               "/api/v3/exchangeInfo?showPermissionSets=false&symbols=%5B%22BTCUSDT%22%2C%22BNBBTC%22%5D"
           } == request
  end

  test "exchange_info empty query request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.ExchangeInfo.Query{}
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request()

    assert %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://testnet.binance.vision",
             url: "/api/v3/exchangeInfo"
           } == request
  end

  test "exchange_info permissions query request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.ExchangeInfo.Query{
               permissions: [:MARGIN, :LEVERAGED]
             }
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request()

    assert %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://testnet.binance.vision",
             url: "/api/v3/exchangeInfo?permissions=%5B%22MARGIN%22%2C%22LEVERAGED%22%5D"
           } == request
  end

  test "exchange_info symbol status query request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.ExchangeInfo.Query{symbolStatus: :HALT}
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request()

    assert %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://testnet.binance.vision",
             url: "/api/v3/exchangeInfo?symbolStatus=HALT"
           } == request
  end

  test "exchange_info show permission sets query request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.ExchangeInfo.Query{showPermissionSets: false}
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request()

    assert %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://testnet.binance.vision",
             url: "/api/v3/exchangeInfo?showPermissionSets=false"
           } == request
  end

  test "exchange_info permissions, show permission sets and symbol status query request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.ExchangeInfo.Query{
               permissions: [:MARGIN, :LEVERAGED],
               showPermissionSets: false,
               symbolStatus: :HALT
             }
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request()

    assert %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://testnet.binance.vision",
             url:
               "/api/v3/exchangeInfo?permissions=%5B%22MARGIN%22%2C%22LEVERAGED%22%5D&showPermissionSets=false&symbolStatus=HALT"
           } == request
  end
end
