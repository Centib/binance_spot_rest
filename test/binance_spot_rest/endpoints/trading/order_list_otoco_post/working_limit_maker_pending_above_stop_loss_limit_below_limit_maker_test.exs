defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery

  def full_valid_query do
    %WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery{
      listClientOrderId: "2inzWQdDvZLHbbAmAozX2N",
      # ---
      symbol: "LTCBTC",
      selfTradePreventionMode: BinanceSpotRest.Enums.SelfTradePreventionMode._EXPIRE_BOTH(),
      newOrderRespType: BinanceSpotRest.Enums.NewOrderRespType._ACK(),
      recvWindow: 3000,
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
      pendingSide: BinanceSpotRest.Enums.Side._BUY(),
      pendingQuantity: Decimal.new("1.0"),
      # ---
      pendingBelowType: BinanceSpotRest.Enums.OrderType._LIMIT_MAKER(),
      pendingBelowPrice: Decimal.new("0.001"),
      pendingBelowClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      pendingBelowStrategyId: 2,
      pendingBelowStrategyType: 1_000_200,
      pendingBelowIcebergQty: Decimal.new("0.5"),
      # ---
      pendingAboveType: BinanceSpotRest.Enums.OrderType._STOP_LOSS_LIMIT(),
      pendingAboveTimeInForce: BinanceSpotRest.Enums.TimeInForce._GTC(),
      pendingAbovePrice: Decimal.new("0.00129"),
      pendingAboveStopPrice: Decimal.new("0.00129"),
      pendingAboveTrailingDelta: 10,
      pendingAboveClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      pendingAboveStrategyId: 2,
      pendingAboveStrategyType: 1_000_200,
      pendingAboveIcebergQty: Decimal.new("0.5")
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
                   "pendingAboveStopPrice=0.00129&" <>
                   "pendingAboveStrategyId=2&" <>
                   "pendingAboveStrategyType=1000200&" <>
                   "pendingAboveTimeInForce=GTC&" <>
                   "pendingAboveTrailingDelta=10&" <>
                   "pendingAboveType=STOP_LOSS_LIMIT&" <>
                   "pendingBelowClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "pendingBelowIcebergQty=0.5&" <>
                   "pendingBelowPrice=0.001&" <>
                   "pendingBelowStrategyId=2&" <>
                   "pendingBelowStrategyType=1000200&" <>
                   "pendingBelowType=LIMIT_MAKER&" <>
                   "pendingQuantity=1.0&" <>
                   "pendingSide=BUY&" <>
                   "recvWindow=3000&" <>
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
      :pendingBelowPrice,
      :pendingAboveTimeInForce,
      :pendingAbovePrice
    ]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(
                   &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
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
      :pendingBelowType,
      :pendingBelowClientOrderId,
      :pendingBelowStrategyId,
      :pendingBelowStrategyType,
      :pendingBelowIcebergQty,
      :pendingAboveType,
      :pendingAboveClientOrderId,
      :pendingAboveStrategyId,
      :pendingAboveStrategyType,
      :pendingAboveIcebergQty
    ]

    test "valid without optional fields" do
      assert {:ok, %WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
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
      pendingBelowType: :LIMIT_MAKER_INVALID,
      pendingBelowPrice: "0.00129",
      pendingBelowClientOrderId: 4567,
      pendingBelowStrategyId: 2.5,
      pendingBelowStrategyType: "1_000_200",
      pendingBelowIcebergQty: "0.5",
      # ---
      pendingAboveType: :STOP_LOSS_LIMIT_INVALID,
      pendingAboveTimeInForce: :GTC_INVALID,
      pendingAbovePrice: "0.00129",
      pendingAboveStopPrice: "0.001",
      pendingAboveTrailingDelta: 10.5,
      pendingAboveClientOrderId: 1234,
      pendingAboveStrategyId: 2.5,
      pendingAboveStrategyType: "1_000_200",
      pendingAboveIcebergQty: "0.5"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(
                   &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
                 )
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (inclusive) (pending above):" do
    @inclusive [:pendingAboveStopPrice, :pendingAboveTrailingDelta]

    test "valid with one of [:aboveStopPrice, :aboveTrailingDelta]" do
      assert {:ok, %WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 0))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 1))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:aboveStopPrice, :aboveTrailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
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
                 &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (specific) (pending below):" do
    # No timeInForce is expected for LimitMaker orders – no test.

    test "incorrect pendingBelowIcebergQty (not lower than pendingQuantity)" do
      assert {:error, %{field: :pendingBelowIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingBelowIcebergQty, Decimal.new("1.5"))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (specific) (pending above):" do
    test "incorrect pendingAboveTimeInForce (FOC) when pendingAboveIcebergQty is set" do
      assert {:error, %{field: :pendingAboveTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAboveTimeInForce, BinanceSpotRest.Enums.TimeInForce._FOK())
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect pendingAboveTimeInForce (IOC) when pendingAboveIcebergQty is set" do
      assert {:error, %{field: :pendingAboveTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAboveTimeInForce, BinanceSpotRest.Enums.TimeInForce._IOC())
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect pendingAboveIcebergQty (not lower than pendingQuantity)" do
      assert {:error, %{field: :pendingAboveIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAboveIcebergQty, Decimal.new("1.5"))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation price compare (pending)" do
    test "error if pendingAboveStopPrice is lower than pendingBelowPrice" do
      assert {:error, _} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAboveStopPrice, Decimal.new("0.001"))
               ~>> Map.put(:pendingBelowPrice, Decimal.new("0.002"))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end

    test "error if pendingAboveStopPrice is equal than pendingBelowPrice" do
      assert {:error, _} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAboveStopPrice, Decimal.new("0.001"))
               ~>> Map.put(:pendingBelowPrice, Decimal.new("0.001"))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end

    test "ok if pendingAboveStopPrice is greater than pendingBelowPrice" do
      assert {:ok, %WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingAboveStopPrice, Decimal.new("0.002"))
               ~>> Map.put(:pendingBelowPrice, Decimal.new("0.001"))
               ~>> then(
                 &struct(WorkingLimitMakerPendingAboveStopLossLimitBelowLimitMakerQuery, &1)
               )
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
