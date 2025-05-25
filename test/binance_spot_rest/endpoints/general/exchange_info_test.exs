defmodule BinanceSpotRest.Endpoints.General.ExchangeInfoTest do
  @moduledoc false
  use ExUnit.Case, async: true
  import Loe

  test "exchange_info symbol request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.ExchangeInfo.SymbolQuery{symbol: "BNBBTC"}
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request()

    assert request == %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://testnet.binance.vision",
             url: "/api/v3/exchangeInfo?symbol=BNBBTC"
           }
  end

  test "exchange_info symbols request" do
    assert {:ok, request} =
             %BinanceSpotRest.Endpoints.General.ExchangeInfo.SymbolsQuery{symbols: ["BTCUSDT", "BNBBTC"]}
             ~>> BinanceSpotRest.Query.validate()
             ~>> BinanceSpotRest.Query.prepare()
             ~>> BinanceSpotRest.Client.create_request()

    assert request == %BinanceSpotRest.Client.Request{
             method: :get,
             headers: [],
             base_url: "https://testnet.binance.vision",
             url: "/api/v3/exchangeInfo?symbols=%5B%22BTCUSDT%22%2C%22BNBBTC%22%5D"
           }
  end
end
