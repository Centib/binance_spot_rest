defmodule BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.StopLossTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.StopLossQuery

  def full_valid_query do
    %StopLossQuery{
      symbol: "LTCBTC",
      side: BinanceSpotRest.Enums.Side._BUY(),
      type: BinanceSpotRest.Enums.OrderType._STOP_LOSS(),
      quantity: Decimal.new("1.0"),
      stopPrice: Decimal.new("20.0"),
      trailingDelta: 10,
      newClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      strategyId: 2,
      strategyType: 1_000_200,
      selfTradePreventionMode: BinanceSpotRest.Enums.SelfTradePreventionMode._EXPIRE_BOTH(),
      newOrderRespType: BinanceSpotRest.Enums.NewOrderRespType._ACK(),
      recvWindow: 3000,
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
                   "newClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "newOrderRespType=ACK&" <>
                   "orderRateLimitExceededMode=CANCEL_ONLY&" <>
                   "quantity=1.0&" <>
                   "recvWindow=3000&" <>
                   "selfTradePreventionMode=EXPIRE_BOTH&" <>
                   "side=BUY&" <>
                   "stopPrice=20.0&" <>
                   "strategyId=2&" <>
                   "strategyType=1000200&" <>
                   "symbol=LTCBTC&" <>
                   "trailingDelta=10&" <>
                   "type=STOP_LOSS&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }
    end
  end

  describe "validation (required):" do
    @required [:symbol, :side, :quantity, :cancelReplaceMode]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(StopLossQuery, &1))
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
      :selfTradePreventionMode,
      :newOrderRespType,
      :recvWindow,
      :cancelNewClientOrderId,
      :cancelRestrictions,
      :orderRateLimitExceededMode
    ]

    test "valid without optional fields" do
      assert {:ok, %StopLossQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(StopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (inclusive) (cancel specific):" do
    @inclusive [:cancelOrderId, :cancelOrigClientOrderId]

    test "valid with one of [:cancelOrderId, :cancelOrigClientOrderId]" do
      assert {:ok, %StopLossQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:cancelOrderId)
               ~>> then(&struct(StopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %StopLossQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:cancelOrigClientOrderId)
               ~>> then(&struct(StopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:cancelOrderId, :cancelOrigClientOrderId] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(StopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (inclusive):" do
    @inclusive [:stopPrice, :trailingDelta]

    test "valid with one of [:stopPrice, :trailingDelta]" do
      assert {:ok, %StopLossQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:stopPrice)
               ~>> then(&struct(StopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %StopLossQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:trailingDelta)
               ~>> then(&struct(StopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:stopPrice, :trailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(StopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (type):" do
    @bad_types [
      symbol: :LTCBTC,
      side: :BUY_INVALID,
      type: :STOP_LOSS_INVALID,
      quantity: "1.0",
      stopPrice: "20.0",
      trailingDelta: 10.5,
      newClientOrderId: 1234,
      strategyId: 2.5,
      strategyType: "1_000_200",
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
                 ~>> then(&struct(StopLossQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end
end
