defmodule BinanceSpotRest.Endpoints.Trading.OrderTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.Order

  describe "request" do
    test "limit" do
      assert {:ok, request} =
               %Order.LimitQuery{
                 symbol: "LTCBTC",
                 side: BinanceSpotRest.Enums.Side._BUY(),
                 type: BinanceSpotRest.Enums.OrderType._LIMIT(),
                 timeInForce: BinanceSpotRest.Enums.TimeInForce._GTC(),
                 quantity: Decimal.new("1.0"),
                 price: Decimal.new("0.00129"),
                 newClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
                 strategyId: 2,
                 strategyType: 1_000_200,
                 icebergQty: Decimal.new("0.5"),
                 selfTradePreventionMode:
                   BinanceSpotRest.Enums.SelfTradePreventionMode._EXPIRE_BOTH(),
                 newOrderRespType: BinanceSpotRest.Enums.NewOrderRespType._ACK(),
                 recvWindow: 3000
               }
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(
                 base_url: "https://fake.binance.url",
                 headers: [{"FAKE_API_KEY", "fake1234api5678key"}],
                 timestamp_fn: fn -> 1_740_587_673_449 end,
                 signature_fn: fn _, _ -> "fake_signature" end
               )

      assert %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._post(),
               headers: [{"FAKE_API_KEY", "fake1234api5678key"}],
               base_url: "https://fake.binance.url",
               url:
                 "/api/v3/order?" <>
                   "icebergQty=0.5&" <>
                   "newClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "newOrderRespType=ACK&" <>
                   "price=0.00129&" <>
                   "quantity=1.0&" <>
                   "recvWindow=3000&" <>
                   "selfTradePreventionMode=EXPIRE_BOTH&" <>
                   "side=BUY&" <>
                   "strategyId=2&" <>
                   "strategyType=1000200&" <>
                   "symbol=LTCBTC&" <>
                   "timeInForce=GTC&" <>
                   "type=LIMIT&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             } == request
    end

    # test "stop loss limit" do
    #   assert {:ok, request} =
    #            %Order.LimitQuery{
    #              symbol: "BTCUSDT",
    #              interval: :"3m",
    #              startTime: 1_498_793_709_153,
    #              endTime: 1_498_793_809_153,
    #              timeZone: "-1:00",
    #              limit: 150
    #            }
    #            ~>> BinanceSpotRest.Query.validate()
    #            ~>> BinanceSpotRest.Query.prepare()
    #            ~>> BinanceSpotRest.Client.create_request(
    #              headers: [{"FAKE_API_KEY", "fake1234api5678key"}]
    #            )

    #   assert %BinanceSpotRest.Client.Request{
    #            method: BinanceSpotRest.Enums.Method._post(),
    #            headers: [{"X-MBX-APIKEY", BinanceSpotRest.Env.api_key()}],
    #            base_url: "https://testnet.binance.vision",
    #            url:
    #              "/api/v3/order?endTime=1498793809153&interval=3m&limit=150&startTime=1498793709153&symbol=BTCUSDT&timeZone=-1%3A00"
    #          } == request
    # end

    # test "take profit limit" do
    #   assert {:ok, request} =
    #            %Order.LimitQuery{
    #              symbol: "BTCUSDT",
    #              interval: :"3m",
    #              startTime: 1_498_793_709_153,
    #              endTime: 1_498_793_809_153,
    #              timeZone: "-1:00",
    #              limit: 150
    #            }
    #            ~>> BinanceSpotRest.Query.validate()
    #            ~>> BinanceSpotRest.Query.prepare()
    #            ~>> BinanceSpotRest.Client.create_request(
    #              headers: [{"FAKE_API_KEY", "fake1234api5678key"}]
    #            )

    #   assert %BinanceSpotRest.Client.Request{
    #            method: BinanceSpotRest.Enums.Method._post(),
    #            headers: [{"X-MBX-APIKEY", BinanceSpotRest.Env.api_key()}],
    #            base_url: "https://testnet.binance.vision",
    #            url:
    #              "/api/v3/order?endTime=1498793809153&interval=3m&limit=150&startTime=1498793709153&symbol=BTCUSDT&timeZone=-1%3A00"
    #          } == request
    # end

    # test "limit maker" do
    #   assert {:ok, request} =
    #            %Order.LimitQuery{
    #              symbol: "BTCUSDT",
    #              interval: :"3m",
    #              startTime: 1_498_793_709_153,
    #              endTime: 1_498_793_809_153,
    #              timeZone: "-1:00",
    #              limit: 150
    #            }
    #            ~>> BinanceSpotRest.Query.validate()
    #            ~>> BinanceSpotRest.Query.prepare()
    #            ~>> BinanceSpotRest.Client.create_request(
    #              headers: [{"FAKE_API_KEY", "fake1234api5678key"}]
    #            )

    #   assert %BinanceSpotRest.Client.Request{
    #            method: BinanceSpotRest.Enums.Method._post(),
    #            headers: [{"X-MBX-APIKEY", BinanceSpotRest.Env.api_key()}],
    #            base_url: "https://testnet.binance.vision",
    #            url:
    #              "/api/v3/order?endTime=1498793809153&interval=3m&limit=150&startTime=1498793709153&symbol=BTCUSDT&timeZone=-1%3A00"
    #          } == request
    # end

    # test "market" do
    #   assert {:ok, request} =
    #            %Order.LimitQuery{
    #              symbol: "BTCUSDT",
    #              interval: :"3m",
    #              startTime: 1_498_793_709_153,
    #              endTime: 1_498_793_809_153,
    #              timeZone: "-1:00",
    #              limit: 150
    #            }
    #            ~>> BinanceSpotRest.Query.validate()
    #            ~>> BinanceSpotRest.Query.prepare()
    #            ~>> BinanceSpotRest.Client.create_request(
    #              headers: [{"FAKE_API_KEY", "fake1234api5678key"}]
    #            )

    #   assert %BinanceSpotRest.Client.Request{
    #            method: BinanceSpotRest.Enums.Method._post(),
    #            headers: [{"X-MBX-APIKEY", BinanceSpotRest.Env.api_key()}],
    #            base_url: "https://testnet.binance.vision",
    #            url:
    #              "/api/v3/order?endTime=1498793809153&interval=3m&limit=150&startTime=1498793709153&symbol=BTCUSDT&timeZone=-1%3A00"
    #          } == request
    # end

    # test "stop loss" do
    #   assert {:ok, request} =
    #            %Order.LimitQuery{
    #              symbol: "BTCUSDT",
    #              interval: :"3m",
    #              startTime: 1_498_793_709_153,
    #              endTime: 1_498_793_809_153,
    #              timeZone: "-1:00",
    #              limit: 150
    #            }
    #            ~>> BinanceSpotRest.Query.validate()
    #            ~>> BinanceSpotRest.Query.prepare()
    #            ~>> BinanceSpotRest.Client.create_request(
    #              headers: [{"FAKE_API_KEY", "fake1234api5678key"}]
    #            )

    #   assert %BinanceSpotRest.Client.Request{
    #            method: BinanceSpotRest.Enums.Method._post(),
    #            headers: [{"X-MBX-APIKEY", BinanceSpotRest.Env.api_key()}],
    #            base_url: "https://testnet.binance.vision",
    #            url:
    #              "/api/v3/order?endTime=1498793809153&interval=3m&limit=150&startTime=1498793709153&symbol=BTCUSDT&timeZone=-1%3A00"
    #          } == request
    # end

    # test "take profit" do
    #   assert {:ok, request} =
    #            %Order.LimitQuery{
    #              symbol: "BTCUSDT",
    #              interval: :"3m",
    #              startTime: 1_498_793_709_153,
    #              endTime: 1_498_793_809_153,
    #              timeZone: "-1:00",
    #              limit: 150
    #            }
    #            ~>> BinanceSpotRest.Query.validate()
    #            ~>> BinanceSpotRest.Query.prepare()
    #            ~>> BinanceSpotRest.Client.create_request(
    #              headers: [{"FAKE_API_KEY", "fake1234api5678key"}]
    #            )

    #   assert %BinanceSpotRest.Client.Request{
    #            method: BinanceSpotRest.Enums.Method._post(),
    #            headers: [{"X-MBX-APIKEY", BinanceSpotRest.Env.api_key()}],
    #            base_url: "https://testnet.binance.vision",
    #            url:
    #              "/api/v3/order?endTime=1498793809153&interval=3m&limit=150&startTime=1498793709153&symbol=BTCUSDT&timeZone=-1%3A00"
    #          } == request
    # end
  end

  # describe "validation" do
  #   test "invalid without symbol" do
  #     assert {:error, _} =
  #              %Order.LimitQuery{symbol: nil, interval: :"3m"}
  #              ~>> BinanceSpotRest.Query.validate()

  #     assert {:error, _} =
  #              %Order.LimitQuery{interval: :"3m"}
  #              ~>> BinanceSpotRest.Query.validate()
  #   end

  #   test "invalid without interval" do
  #     assert {:error, _} =
  #              %Order.LimitQuery{symbol: "BTCUSDT", interval: nil}
  #              ~>> BinanceSpotRest.Query.validate()

  #     assert {:error, _} =
  #              %Order.LimitQuery{symbol: "BTCUSDT"}
  #              ~>> BinanceSpotRest.Query.validate()
  #   end

  #   test "invalid non-integer startTime" do
  #     assert {:error, _} =
  #              %Order.LimitQuery{
  #                symbol: "BTCUSDT",
  #                interval: :"3m",
  #                startTime: "1_498_793_709_153",
  #                endTime: 1_498_793_809_153,
  #                timeZone: "-1:00",
  #                limit: 150
  #              }
  #              ~>> BinanceSpotRest.Query.validate()
  #   end

  #   test "invalid value timeZone" do
  #     assert {:error, _} =
  #              %Order.LimitQuery{
  #                symbol: "BTCUSDT",
  #                interval: :"3m",
  #                startTime: 1_498_793_709_153,
  #                endTime: 1_498_793_809_153,
  #                timeZone: "-13:00",
  #                limit: 150
  #              }
  #              ~>> BinanceSpotRest.Query.validate()
  #   end

  #   test "invalid value interval" do
  #     assert {:error, _} =
  #              %Order.LimitQuery{
  #                symbol: "BTCUSDT",
  #                interval: :"11m",
  #                startTime: 1_498_793_709_153,
  #                endTime: 1_498_793_809_153,
  #                timeZone: "-1:00",
  #                limit: 150
  #              }
  #              ~>> BinanceSpotRest.Query.validate()
  #   end

  #   test "invalid range limit" do
  #     assert {:error, _} =
  #              %Order.LimitQuery{
  #                symbol: "BTCUSDT",
  #                interval: :"3m",
  #                startTime: 1_498_793_709_153,
  #                endTime: 1_498_793_809_153,
  #                timeZone: "-1:00",
  #                limit: 1001
  #              }
  #              ~>> BinanceSpotRest.Query.validate()
  #   end
  # end
end
