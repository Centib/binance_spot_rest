defmodule BinanceSpotRest.Endpoints.General.ExchangeInfoTest do
  @moduledoc false
  use ExUnit.Case, async: true
  import Loe

  test "exchange_info request" do
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
end
