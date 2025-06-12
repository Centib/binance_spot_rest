defmodule BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.AboveStopLossLimitBelowTakeProfitLimitTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.AboveStopLossLimitBelowTakeProfitLimitQuery

  def full_valid_query do
    %AboveStopLossLimitBelowTakeProfitLimitQuery{
      listClientOrderId: "2inzWQdDvZLHbbAmAozX2N",
      # ---
      symbol: "LTCBTC",
      side: BinanceSpotRest.Enums.Side._BUY(),
      quantity: Decimal.new("1.0"),
      selfTradePreventionMode: BinanceSpotRest.Enums.SelfTradePreventionMode._EXPIRE_BOTH(),
      newOrderRespType: BinanceSpotRest.Enums.NewOrderRespType._ACK(),
      recvWindow: 3000,
      # ---
      belowTimeInForce: BinanceSpotRest.Enums.TimeInForce._GTC(),
      belowPrice: Decimal.new("0.00129"),
      belowIcebergQty: Decimal.new("0.5"),
      belowType: BinanceSpotRest.Enums.OrderType._TAKE_PROFIT_LIMIT(),
      belowStopPrice: Decimal.new("20.0"),
      belowTrailingDelta: 10,
      belowClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      belowStrategyId: 2,
      belowStrategyType: 1_000_200,
      # ---
      aboveType: BinanceSpotRest.Enums.OrderType._STOP_LOSS_LIMIT(),
      aboveTimeInForce: BinanceSpotRest.Enums.TimeInForce._GTC(),
      abovePrice: Decimal.new("0.00129"),
      aboveStopPrice: Decimal.new("0.001"),
      aboveTrailingDelta: 10,
      aboveClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      aboveStrategyId: 2,
      aboveStrategyType: 1_000_200,
      aboveIcebergQty: Decimal.new("0.5")
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
                 "/api/v3/orderList/oco?" <>
                   "aboveClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "aboveIcebergQty=0.5&" <>
                   "abovePrice=0.00129&" <>
                   "aboveStopPrice=0.001&" <>
                   "aboveStrategyId=2&" <>
                   "aboveStrategyType=1000200&" <>
                   "aboveTimeInForce=GTC&" <>
                   "aboveTrailingDelta=10&" <>
                   "aboveType=STOP_LOSS_LIMIT&" <>
                   "belowClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "belowIcebergQty=0.5&" <>
                   "belowPrice=0.00129&" <>
                   "belowStopPrice=20.0&" <>
                   "belowStrategyId=2&" <>
                   "belowStrategyType=1000200&" <>
                   "belowTimeInForce=GTC&" <>
                   "belowTrailingDelta=10&" <>
                   "belowType=TAKE_PROFIT_LIMIT&" <>
                   "listClientOrderId=2inzWQdDvZLHbbAmAozX2N&" <>
                   "newOrderRespType=ACK&" <>
                   "quantity=1.0&" <>
                   "recvWindow=3000&" <>
                   "selfTradePreventionMode=EXPIRE_BOTH&" <>
                   "side=BUY&" <>
                   "symbol=LTCBTC&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }
    end
  end

  describe "validation (required):" do
    @required [
      :symbol,
      :quantity,
      :belowTimeInForce,
      :belowPrice,
      :aboveTimeInForce,
      :abovePrice
    ]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (inclusive) (below):" do
    @inclusive [:belowStopPrice, :belowTrailingDelta]

    test "valid with one of [:belowStopPrice, :belowTrailingDelta]" do
      assert {:ok, %AboveStopLossLimitBelowTakeProfitLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 0))
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %AboveStopLossLimitBelowTakeProfitLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 1))
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:belowStopPrice, :belowTrailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (inclusive) (above):" do
    @inclusive [:aboveStopPrice, :aboveTrailingDelta]

    test "valid with one of [:aboveStopPrice, :aboveTrailingDelta]" do
      assert {:ok, %AboveStopLossLimitBelowTakeProfitLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 0))
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %AboveStopLossLimitBelowTakeProfitLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 1))
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:aboveStopPrice, :aboveTrailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (optional):" do
    @optional [
      :side,
      :listClientOrderId,
      :belowIcebergQty,
      :belowType,
      :belowClientOrderId,
      :belowStrategyId,
      :belowStrategyType,
      :aboveType,
      :aboveClientOrderId,
      :aboveStrategyId,
      :aboveStrategyType,
      :aboveIcebergQty,
      :selfTradePreventionMode,
      :newOrderRespType,
      :recvWindow
    ]

    test "valid without optional fields" do
      assert {:ok, %AboveStopLossLimitBelowTakeProfitLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (type):" do
    @bad_types [
      listClientOrderId: 1234,
      # ---
      symbol: :LTCBTC,
      side: :BUY_INVALID,
      quantity: "1.0",
      selfTradePreventionMode: :EXPIRE_BOTH_INVALID,
      newOrderRespType: :ACK_INVALID,
      recvWindow: "3000",
      # ---
      belowTimeInForce: :GTC_INVALID,
      belowPrice: "0.00129",
      belowIcebergQty: "0.5",
      belowType: :TAKE_PROFIT_LIMIT_INVALID,
      belowStopPrice: "20.0",
      belowTrailingDelta: 10.5,
      belowClientOrderId: 1234,
      belowStrategyId: 2.4,
      belowStrategyType: "1_000_200",
      # ---
      aboveType: :STOP_LOSS_LIMIT_INVALID,
      aboveTimeInForce: :GTC_INVALID,
      abovePrice: "0.00129",
      aboveStopPrice: "0.001",
      aboveTrailingDelta: 10.5,
      aboveClientOrderId: 1234,
      aboveStrategyId: 2.5,
      aboveStrategyType: "1_000_200",
      aboveIcebergQty: "0.5"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (specific) (below):" do
    test "incorrect belowTimeInForce (FOC) when belowIcebergQty is set" do
      assert {:error, %{field: :belowTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:belowTimeInForce, BinanceSpotRest.Enums.TimeInForce._FOK())
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect belowTimeInForce (IOC) when belowIcebergQty is set" do
      assert {:error, %{field: :belowTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:belowTimeInForce, BinanceSpotRest.Enums.TimeInForce._IOC())
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect belowIcebergQty (not lower than quantity)" do
      assert {:error, %{field: :belowIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:belowIcebergQty, Decimal.new("1.5"))
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (specific) (above):" do
    test "incorrect aboveTimeInForce (FOC) when aboveIcebergQty is set" do
      assert {:error, %{field: :aboveTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:aboveTimeInForce, BinanceSpotRest.Enums.TimeInForce._FOK())
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect aboveTimeInForce (IOC) when aboveIcebergQty is set" do
      assert {:error, %{field: :aboveTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:aboveTimeInForce, BinanceSpotRest.Enums.TimeInForce._IOC())
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect aboveIcebergQty (not lower than quantity)" do
      assert {:error, %{field: :aboveIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:aboveIcebergQty, Decimal.new("1.5"))
               ~>> then(&struct(AboveStopLossLimitBelowTakeProfitLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
