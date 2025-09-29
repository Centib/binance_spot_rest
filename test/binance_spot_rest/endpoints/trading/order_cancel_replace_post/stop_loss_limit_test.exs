defmodule BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.StopLossLimitTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.StopLossLimitQuery

  def full_valid_query do
    %StopLossLimitQuery{
      symbol: "LTCBTC",
      side: BinanceSpotRest.Enums.Side._BUY(),
      type: BinanceSpotRest.Enums.OrderType._STOP_LOSS_LIMIT(),
      timeInForce: BinanceSpotRest.Enums.TimeInForce._GTC(),
      quantity: Decimal.new("1.0"),
      price: Decimal.new("0.00129"),
      stopPrice: Decimal.new("0.001"),
      trailingDelta: 10,
      newClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      strategyId: 2,
      strategyType: 1_000_200,
      icebergQty: Decimal.new("0.5"),
      selfTradePreventionMode: BinanceSpotRest.Enums.SelfTradePreventionMode._EXPIRE_BOTH(),
      newOrderRespType: BinanceSpotRest.Enums.NewOrderRespType._ACK(),
      recvWindow: Decimal.new("3000.123"),
      cancelReplaceMode: BinanceSpotRest.Enums.CancelReplaceMode._ALLOW_FAILURE(),
      cancelNewClientOrderId: "cancelNewClientOrderId",
      cancelOrigClientOrderId: "cancelOrigClientOrderId",
      cancelOrderId: 23_000,
      cancelRestrictions: BinanceSpotRest.Enums.CancelRestrictions._ONLY_NEW(),
      orderRateLimitExceededMode: BinanceSpotRest.Enums.OrderRateLimitExceededMode._CANCEL_ONLY()
    }
  end

  describe "request" do
    test "all params" do
      assert {:ok, request} =
               full_valid_query()
               ~>> BinanceSpotRest.Query.validate()
               ~>> BinanceSpotRest.Query.prepare()
               ~>> BinanceSpotRest.Client.create_request(
                 base_url: "https://fake.binance.url",
                 headers: [{"FAKE_API_KEY", "fake1234api5678key"}],
                 timestamp_fn: fn -> 1_740_587_673_449 end,
                 signature_fn: fn _, _ -> "fake_signature" end
               )

      assert request == %BinanceSpotRest.Client.Request{
               method: BinanceSpotRest.Enums.Method._post(),
               headers: [{"FAKE_API_KEY", "fake1234api5678key"}],
               base_url: "https://fake.binance.url",
               url:
                 "/api/v3/order/cancelReplace?" <>
                   "cancelNewClientOrderId=cancelNewClientOrderId&" <>
                   "cancelOrderId=23000&" <>
                   "cancelOrigClientOrderId=cancelOrigClientOrderId&" <>
                   "cancelReplaceMode=ALLOW_FAILURE&" <>
                   "cancelRestrictions=ONLY_NEW&" <>
                   "icebergQty=0.5&" <>
                   "newClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "newOrderRespType=ACK&" <>
                   "orderRateLimitExceededMode=CANCEL_ONLY&" <>
                   "price=0.00129&" <>
                   "quantity=1.0&" <>
                   "recvWindow=3000.123&" <>
                   "selfTradePreventionMode=EXPIRE_BOTH&" <>
                   "side=BUY&" <>
                   "stopPrice=0.001&" <>
                   "strategyId=2&" <>
                   "strategyType=1000200&" <>
                   "symbol=LTCBTC&" <>
                   "timeInForce=GTC&" <>
                   "trailingDelta=10&" <>
                   "type=STOP_LOSS_LIMIT&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }
    end
  end

  describe "validation (required):" do
    @required [:symbol, :side, :timeInForce, :quantity, :price, :cancelReplaceMode]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(StopLossLimitQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (optional):" do
    @optional [
      :type,
      :newClientOrderId,
      :strategyId,
      :strategyType,
      :icebergQty,
      :selfTradePreventionMode,
      :newOrderRespType,
      :recvWindow,
      :cancelNewClientOrderId,
      :cancelRestrictions,
      :orderRateLimitExceededMode
    ]

    test "valid without optional fields" do
      assert {:ok, %StopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(StopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (inclusive) (cancel specific):" do
    @inclusive [:cancelOrderId, :cancelOrigClientOrderId]

    test "valid with one of [:cancelOrderId, :cancelOrigClientOrderId]" do
      assert {:ok, %StopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:cancelOrderId)
               ~>> then(&struct(StopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %StopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:cancelOrigClientOrderId)
               ~>> then(&struct(StopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:cancelOrderId, :cancelOrigClientOrderId] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(StopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (inclusive):" do
    @inclusive [:stopPrice, :trailingDelta]

    test "valid with one of [:stopPrice, :trailingDelta]" do
      assert {:ok, %StopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:stopPrice)
               ~>> then(&struct(StopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %StopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:trailingDelta)
               ~>> then(&struct(StopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:stopPrice, :trailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(StopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (type):" do
    @bad_types [
      symbol: :LTCBTC,
      side: :BUY_INVALID,
      type: BinanceSpotRest.Enums.OrderType._LIMIT(),
      timeInForce: :GTC_INVALID,
      quantity: "1.0",
      price: 0.00129,
      stopPrice: "0.001",
      trailingDelta: 10.45,
      newClientOrderId: 123,
      strategyId: 2.5,
      strategyType: "1_000_200",
      icebergQty: "0.5",
      selfTradePreventionMode: :EXPIRE_BOTH_INVALID,
      newOrderRespType: :ACK_INVALID,
      recvWindow: "3000",
      cancelReplaceMode: :ALLOW_FAILURE_INVALID,
      cancelNewClientOrderId: 1234,
      cancelOrigClientOrderId: 5678,
      cancelOrderId: "23_000",
      cancelRestrictions: :ONLY_NEW_INVALID,
      orderRateLimitExceededMode: :CANCEL_ONLY_INVALID
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(StopLossLimitQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (specific):" do
    test "incorrect timeInForce (FOC) when icebergQty is set" do
      assert {:error, %{field: :timeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:timeInForce, BinanceSpotRest.Enums.TimeInForce._FOK())
               ~>> then(&struct(StopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect timeInForce (IOC) when icebergQty is set" do
      assert {:error, %{field: :timeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:timeInForce, BinanceSpotRest.Enums.TimeInForce._IOC())
               ~>> then(&struct(StopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect icebergQty (not lower than quantity)" do
      assert {:error, %{field: :icebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:icebergQty, Decimal.new("1.5"))
               ~>> then(&struct(StopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
