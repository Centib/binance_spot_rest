defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.WorkingLimitPendingAboveLimitMakerBelowStopLossTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.WorkingLimitPendingAboveLimitMakerBelowStopLossQuery

  def full_valid_query do
    %WorkingLimitPendingAboveLimitMakerBelowStopLossQuery{
      listClientOrderId: "2inzWQdDvZLHbbAmAozX2N",
      # ---
      symbol: "LTCBTC",
      selfTradePreventionMode: BinanceSpotRest.Enums.SelfTradePreventionMode._EXPIRE_BOTH(),
      newOrderRespType: BinanceSpotRest.Enums.NewOrderRespType._ACK(),
      recvWindow: 3000,
      # ---
      workingSide: BinanceSpotRest.Enums.Side._BUY(),
      workingType: BinanceSpotRest.Enums.OrderType._LIMIT(),
      workingTimeInForce: BinanceSpotRest.Enums.TimeInForce._GTC(),
      workingQuantity: Decimal.new("1.0"),
      workingPrice: Decimal.new("0.00129"),
      workingClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      workingStrategyId: 2,
      workingStrategyType: 1_000_200,
      workingIcebergQty: Decimal.new("0.5"),
      # ---
      pendingSide: BinanceSpotRest.Enums.Side._SELL(),
      pendingQuantity: Decimal.new("1.0"),
      # ---
      pendingAboveType: BinanceSpotRest.Enums.OrderType._LIMIT_MAKER(),
      pendingAbovePrice: Decimal.new("0.00129"),
      pendingAboveClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      pendingAboveStrategyId: 2,
      pendingAboveStrategyType: 1_000_200,
      pendingAboveIcebergQty: Decimal.new("0.5"),
      # ---
      pendingBelowType: BinanceSpotRest.Enums.OrderType._STOP_LOSS(),
      pendingBelowStopPrice: Decimal.new("0.001"),
      pendingBelowTrailingDelta: 10,
      pendingBelowClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      pendingBelowStrategyId: 2,
      pendingBelowStrategyType: 1_000_200
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
                   "pendingAboveIcebergQty=0.5&" <>
                   "pendingAbovePrice=0.00129&" <>
                   "pendingAboveStrategyId=2&" <>
                   "pendingAboveStrategyType=1000200&" <>
                   "pendingAboveType=LIMIT_MAKER&" <>
                   "pendingBelowClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "pendingBelowStopPrice=0.001&" <>
                   "pendingBelowStrategyId=2&" <>
                   "pendingBelowStrategyType=1000200&" <>
                   "pendingBelowTrailingDelta=10&" <>
                   "pendingBelowType=STOP_LOSS&" <>
                   "pendingQuantity=1.0&" <>
                   "pendingSide=SELL&" <>
                   "recvWindow=3000&" <>
                   "selfTradePreventionMode=EXPIRE_BOTH&" <>
                   "symbol=LTCBTC&" <>
                   "workingClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "workingIcebergQty=0.5&" <>
                   "workingPrice=0.00129&" <>
                   "workingQuantity=1.0&" <>
                   "workingSide=BUY&" <>
                   "workingStrategyId=2&" <>
                   "workingStrategyType=1000200&" <>
                   "workingTimeInForce=GTC&" <>
                   "workingType=LIMIT&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }
    end
  end

  describe "validation (required):" do
    @required [
      :symbol,
      :workingSide,
      :workingTimeInForce,
      :workingQuantity,
      :workingPrice,
      :pendingQuantity,
      :pendingAbovePrice
    ]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
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
      :pendingAboveIcebergQty,
      :pendingBelowType,
      :pendingBelowClientOrderId,
      :pendingBelowStrategyId,
      :pendingBelowStrategyType
    ]

    test "valid without optional fields" do
      assert {:ok, %WorkingLimitPendingAboveLimitMakerBelowStopLossQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
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
      workingTimeInForce: :GTC_INVALID,
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
      pendingAboveType: :LIMIT_MAKER_INVALID,
      pendingAbovePrice: "0.00129",
      pendingAboveClientOrderId: 4567,
      pendingAboveStrategyId: 2.5,
      pendingAboveStrategyType: "1_000_200",
      pendingAboveIcebergQty: "0.5",
      # ---
      pendingBelowType: :STOP_LOSS_LIMIT_INVALID,
      pendingBelowStopPrice: "0.001",
      pendingBelowTrailingDelta: 10.5,
      pendingBelowClientOrderId: 1234,
      pendingBelowStrategyId: 2.5,
      pendingBelowStrategyType: "1_000_200"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (inclusive) (pending below):" do
    @inclusive [:pendingBelowStopPrice, :pendingBelowTrailingDelta]

    test "valid with one of [:belowStopPrice, :belowTrailingDelta]" do
      assert {:ok, %WorkingLimitPendingAboveLimitMakerBelowStopLossQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 0))
               ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %WorkingLimitPendingAboveLimitMakerBelowStopLossQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 1))
               ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:belowStopPrice, :belowTrailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (specific) (working):" do
    test "incorrect workingTimeInForce (FOC) when workingIcebergQty is set" do
      assert {:error, %{field: :workingTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:workingTimeInForce, BinanceSpotRest.Enums.TimeInForce._FOK())
               ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect workingTimeInForce (IOC) when workingIcebergQty is set" do
      assert {:error, %{field: :workingTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:workingTimeInForce, BinanceSpotRest.Enums.TimeInForce._IOC())
               ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect workingIcebergQty (not lower than quantity)" do
      assert {:error, %{field: :workingIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:workingIcebergQty, Decimal.new("1.5"))
               ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (specific) (pending above):" do
    # No timeInForce is expected for LimitMaker orders – no test.

    test "incorrect pendingAboveIcebergQty (not lower than pendingQuantity)" do
      assert {:error, %{field: :pendingAboveIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAboveIcebergQty, Decimal.new("1.5"))
               ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation price compare (pending)" do
    test "error if pendingAbovePrice is lower than pendingBelowStopPrice" do
      assert {:error, _} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAbovePrice, Decimal.new("0.001"))
               ~>> Map.put(:pendingBelowStopPrice, Decimal.new("0.002"))
               ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "error if pendingAbovePrice is equal than pendingBelowStopPrice" do
      assert {:error, _} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAbovePrice, Decimal.new("0.001"))
               ~>> Map.put(:pendingBelowStopPrice, Decimal.new("0.001"))
               ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "ok if pendingAbovePrice is greater than pendingBelowStopPrice" do
      assert {:ok, %WorkingLimitPendingAboveLimitMakerBelowStopLossQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAbovePrice, Decimal.new("0.002"))
               ~>> Map.put(:pendingBelowStopPrice, Decimal.new("0.001"))
               ~>> then(&struct(WorkingLimitPendingAboveLimitMakerBelowStopLossQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
