defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery

  def full_valid_query do
    %WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery{
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
      workingPrice: Decimal.new("0.0008"),
      workingClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      workingStrategyId: 2,
      workingStrategyType: 1_000_200,
      workingIcebergQty: Decimal.new("0.5"),
      # ---
      pendingSide: BinanceSpotRest.Enums.Side._SELL(),
      pendingQuantity: Decimal.new("1.0"),
      # ---
      pendingAboveType: BinanceSpotRest.Enums.OrderType._TAKE_PROFIT(),
      pendingAboveStopPrice: Decimal.new("0.00129"),
      pendingAboveTrailingDelta: 10,
      pendingAboveClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      pendingAboveStrategyId: 2,
      pendingAboveStrategyType: 1_000_200,
      # ---
      pendingBelowType: BinanceSpotRest.Enums.OrderType._STOP_LOSS_LIMIT(),
      pendingBelowTimeInForce: BinanceSpotRest.Enums.TimeInForce._GTC(),
      pendingBelowPrice: Decimal.new("0.00129"),
      pendingBelowStopPrice: Decimal.new("0.001"),
      pendingBelowTrailingDelta: 10,
      pendingBelowClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      pendingBelowStrategyId: 2,
      pendingBelowStrategyType: 1_000_200,
      pendingBelowIcebergQty: Decimal.new("0.5")
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
                 "/api/v3/orderList/otoco?" <>
                   "listClientOrderId=2inzWQdDvZLHbbAmAozX2N&" <>
                   "newOrderRespType=ACK&" <>
                   "pendingAboveClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "pendingAboveStopPrice=0.00129&" <>
                   "pendingAboveStrategyId=2&" <>
                   "pendingAboveStrategyType=1000200&" <>
                   "pendingAboveTrailingDelta=10&" <>
                   "pendingAboveType=TAKE_PROFIT&" <>
                   "pendingBelowClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "pendingBelowIcebergQty=0.5&" <>
                   "pendingBelowPrice=0.00129&" <>
                   "pendingBelowStopPrice=0.001&" <>
                   "pendingBelowStrategyId=2&" <>
                   "pendingBelowStrategyType=1000200&" <>
                   "pendingBelowTimeInForce=GTC&" <>
                   "pendingBelowTrailingDelta=10&" <>
                   "pendingBelowType=STOP_LOSS_LIMIT&" <>
                   "pendingQuantity=1.0&" <>
                   "pendingSide=SELL&" <>
                   "recvWindow=3000.123&" <>
                   "selfTradePreventionMode=EXPIRE_BOTH&" <>
                   "symbol=LTCBTC&" <>
                   "workingClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "workingIcebergQty=0.5&" <>
                   "workingPrice=0.0008&" <>
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
      :pendingQuantity,
      :pendingBelowTimeInForce,
      :pendingBelowPrice
    ]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(
                   &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
                 )
                 ~>> BinanceSpotRest.Query.validate()
      end
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
      :pendingSide,
      :pendingAboveType,
      :pendingAboveClientOrderId,
      :pendingAboveStrategyId,
      :pendingAboveStrategyType,
      :pendingBelowType,
      :pendingBelowClientOrderId,
      :pendingBelowStrategyId,
      :pendingBelowStrategyType,
      :pendingBelowIcebergQty
    ]

    test "valid without optional fields" do
      assert {:ok, %WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
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
      pendingQuantity: "1.0",
      # ---
      pendingAboveType: :TAKE_PROFIT_INVALID,
      pendingAboveStopPrice: "20.0",
      pendingAboveTrailingDelta: 10.5,
      pendingAboveClientOrderId: 1234,
      pendingAboveStrategyId: 2.4,
      pendingAboveStrategyType: "1_000_200",
      # ---
      pendingBelowType: :STOP_LOSS_LIMIT_INVALID,
      pendingBelowTimeInForce: :GTC_INVALID,
      pendingBelowPrice: "0.00129",
      pendingBelowStopPrice: "0.001",
      pendingBelowTrailingDelta: 10.5,
      pendingBelowClientOrderId: 1234,
      pendingBelowStrategyId: 2.5,
      pendingBelowStrategyType: "1_000_200",
      pendingBelowIcebergQty: "0.5"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(
                   &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
                 )
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (inclusive) (pending below):" do
    @inclusive [:pendingBelowStopPrice, :pendingBelowTrailingDelta]

    test "valid with one of [:belowStopPrice, :belowTrailingDelta]" do
      assert {:ok, %WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 0))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 1))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:belowStopPrice, :belowTrailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (specific) (working):" do
    # No workingTimeInForce is expected for LimitMaker orders – no test.

    test "incorrect workingIcebergQty (not lower than quantity)" do
      assert {:error, %{field: :workingIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:workingIcebergQty, Decimal.new("1.5"))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (specific) (pending below):" do
    test "incorrect pendingBelowTimeInForce (FOC) when pendingBelowIcebergQty is set" do
      assert {:error, %{field: :pendingBelowTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingBelowTimeInForce, BinanceSpotRest.Enums.TimeInForce._FOK())
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect pendingBelowTimeInForce (IOC) when pendingBelowIcebergQty is set" do
      assert {:error, %{field: :pendingBelowTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingBelowTimeInForce, BinanceSpotRest.Enums.TimeInForce._IOC())
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect pendingBelowIcebergQty (not lower than pendingQuantity)" do
      assert {:error, %{field: :pendingBelowIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingBelowIcebergQty, Decimal.new("1.5"))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (inclusive) (pending above):" do
    @inclusive [:pendingAboveStopPrice, :pendingAboveTrailingDelta]

    test "valid with one of [:pendingAboveStopPrice, :pendingAboveTrailingDelta]" do
      assert {:ok, %WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 0))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 1))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:pendingAboveStopPrice, :pendingAboveTrailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation price compare (pending)" do
    test "error if pendingAboveStopPrice is lower than pendingBelowStopPrice" do
      assert {:error, _} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAboveStopPrice, Decimal.new("0.001"))
               ~>> Map.put(:pendingBelowStopPrice, Decimal.new("0.002"))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end

    test "error if pendingAboveStopPrice is equal than pendingBelowStopPrice" do
      assert {:error, _} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAboveStopPrice, Decimal.new("0.001"))
               ~>> Map.put(:pendingBelowStopPrice, Decimal.new("0.001"))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end

    test "ok if pendingAboveStopPrice is greater than pendingBelowStopPrice" do
      assert {:ok, %WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAboveStopPrice, Decimal.new("0.002"))
               ~>> Map.put(:pendingBelowStopPrice, Decimal.new("0.001"))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveTakeProfitBelowStopLossLimitQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
