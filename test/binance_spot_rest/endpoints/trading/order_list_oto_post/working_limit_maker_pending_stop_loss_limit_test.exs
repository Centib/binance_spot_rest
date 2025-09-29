defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.WorkingLimitMakerPendingStopLossLimitTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.WorkingLimitMakerPendingStopLossLimitQuery

  def full_valid_query do
    %WorkingLimitMakerPendingStopLossLimitQuery{
      listClientOrderId: "2inzWQdDvZLHbbAmAozX2N",
      # ---
      symbol: "LTCBTC",
      selfTradePreventionMode: BinanceSpotRest.Enums.SelfTradePreventionMode._EXPIRE_BOTH(),
      newOrderRespType: BinanceSpotRest.Enums.NewOrderRespType._ACK(),
      recvWindow: Decimal.new("3000.123"),
      # ---
      workingSide: BinanceSpotRest.Enums.Side._BUY(),
      workingType: BinanceSpotRest.Enums.OrderType._LIMIT_MAKER(),
      workingQuantity: Decimal.new("1.0"),
      workingPrice: Decimal.new("0.00129"),
      workingClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      workingStrategyId: 2,
      workingStrategyType: 1_000_200,
      workingIcebergQty: Decimal.new("0.5"),
      # ---
      pendingSide: BinanceSpotRest.Enums.Side._BUY(),
      pendingType: BinanceSpotRest.Enums.OrderType._STOP_LOSS_LIMIT(),
      pendingTimeInForce: BinanceSpotRest.Enums.TimeInForce._GTC(),
      pendingQuantity: Decimal.new("1.0"),
      pendingPrice: Decimal.new("0.00129"),
      pendingStopPrice: Decimal.new("0.00125"),
      pendingTrailingDelta: 10,
      pendingIcebergQty: Decimal.new("0.5"),
      pendingClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      pendingStrategyId: 2,
      pendingStrategyType: 1_000_200
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
                 "/api/v3/orderList/oto?" <>
                   "listClientOrderId=2inzWQdDvZLHbbAmAozX2N&" <>
                   "newOrderRespType=ACK&" <>
                   "pendingClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "pendingIcebergQty=0.5&" <>
                   "pendingPrice=0.00129&" <>
                   "pendingQuantity=1.0&" <>
                   "pendingSide=BUY&" <>
                   "pendingStopPrice=0.00125&" <>
                   "pendingStrategyId=2&" <>
                   "pendingStrategyType=1000200&" <>
                   "pendingTimeInForce=GTC&" <>
                   "pendingTrailingDelta=10&" <>
                   "pendingType=STOP_LOSS_LIMIT&" <>
                   "recvWindow=3000.123&" <>
                   "selfTradePreventionMode=EXPIRE_BOTH&" <>
                   "symbol=LTCBTC&" <>
                   "workingClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "workingIcebergQty=0.5&" <>
                   "workingPrice=0.00129&" <>
                   "workingQuantity=1.0&" <>
                   "workingSide=BUY&" <>
                   "workingStrategyId=2&" <>
                   "workingStrategyType=1000200&" <>
                   "workingType=LIMIT_MAKER&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }
    end
  end

  describe "validation (required):" do
    @required [
      :symbol,
      :workingSide,
      :workingQuantity,
      :workingPrice,
      :pendingSide,
      :pendingQuantity,
      :pendingTimeInForce,
      :pendingPrice
    ]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(WorkingLimitMakerPendingStopLossLimitQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (inclusive) (pending):" do
    @inclusive [:pendingStopPrice, :pendingTrailingDelta]

    test "valid with one of [:pendingStopPrice, :pendingTrailingDelta]" do
      assert {:ok, %WorkingLimitMakerPendingStopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:pendingStopPrice)
               ~>> then(&struct(WorkingLimitMakerPendingStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %WorkingLimitMakerPendingStopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:pendingTrailingDelta)
               ~>> then(&struct(WorkingLimitMakerPendingStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:pendingStopPrice, :pendingTrailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(WorkingLimitMakerPendingStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (optional):" do
    @optional [
      :listClientOrderId,
      :selfTradePreventionMode,
      :newOrderRespType,
      :recvWindow,
      :workingType,
      :workingClientOrderId,
      :workingStrategyId,
      :workingStrategyType,
      :workingIcebergQty,
      :pendingType,
      :pendingClientOrderId,
      :pendingStrategyId,
      :pendingStrategyType,
      :pendingIcebergQty
    ]

    test "valid without optional fields" do
      assert {:ok, %WorkingLimitMakerPendingStopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(WorkingLimitMakerPendingStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (type):" do
    @bad_types [
      listClientOrderId: 1234,
      # ---
      symbol: :LTCBTC,
      selfTradePreventionMode: :EXPIRE_BOTH_INVALID,
      newOrderRespType: :ACK_INVALID,
      recvWindow: "3000",
      # ---
      workingSide: :BUY_INVALID,
      workingType: :LIMIT_INVALID,
      workingQuantity: "1.0",
      workingPrice: "0.00129",
      workingClientOrderId: 5678,
      workingStrategyId: 2.2,
      workingStrategyType: "1_000_200",
      workingIcebergQty: "0.5",
      # ---
      pendingSide: :BUY_INVALID,
      pendingType: :STOP_LOSS_LIMIT_INVALID,
      pendingTimeInForce: :GTC_INVALID,
      pendingQuantity: "1.0",
      pendingPrice: "0.00129",
      pendingStopPrice: "0.00125",
      pendingTrailingDelta: 10.4,
      pendingIcebergQty: "0.5",
      pendingClientOrderId: 5678,
      pendingStrategyId: 2.3,
      pendingStrategyType: "1_000_200"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(WorkingLimitMakerPendingStopLossLimitQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (specific) (working):" do
    # No workingTimeInForce is expected for LimitMaker orders – no test.

    test "incorrect workingIcebergQty (not lower than quantity)" do
      assert {:error, %{field: :workingIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:workingIcebergQty, Decimal.new("1.5"))
               ~>> then(&struct(WorkingLimitMakerPendingStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (specific) (pending):" do
    test "incorrect pendingTimeInForce (FOC) when pendingIcebergQty is set" do
      assert {:error, %{field: :pendingTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingTimeInForce, BinanceSpotRest.Enums.TimeInForce._FOK())
               ~>> then(&struct(WorkingLimitMakerPendingStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect pendingTimeInForce (IOC) when pendingIcebergQty is set" do
      assert {:error, %{field: :pendingTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingTimeInForce, BinanceSpotRest.Enums.TimeInForce._IOC())
               ~>> then(&struct(WorkingLimitMakerPendingStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect pendingIcebergQty (not lower than quantity)" do
      assert {:error, %{field: :pendingIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingIcebergQty, Decimal.new("1.5"))
               ~>> then(&struct(WorkingLimitMakerPendingStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
