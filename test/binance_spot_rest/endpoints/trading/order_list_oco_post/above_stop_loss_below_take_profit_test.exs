defmodule BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.AboveStopLossBelowTakeProfitTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.AboveStopLossBelowTakeProfitQuery

  def full_valid_query do
    %AboveStopLossBelowTakeProfitQuery{
      listClientOrderId: "2inzWQdDvZLHbbAmAozX2N",
      # ---
      symbol: "LTCBTC",
      side: BinanceSpotRest.Enums.Side._BUY(),
      quantity: Decimal.new("1.0"),
      selfTradePreventionMode: BinanceSpotRest.Enums.SelfTradePreventionMode._EXPIRE_BOTH(),
      newOrderRespType: BinanceSpotRest.Enums.NewOrderRespType._ACK(),
      recvWindow: 3000,
      # ---
      belowType: BinanceSpotRest.Enums.OrderType._TAKE_PROFIT(),
      belowStopPrice: Decimal.new("0.001"),
      belowTrailingDelta: 10,
      belowClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      belowStrategyId: 2,
      belowStrategyType: 1_000_200,
      # ---
      aboveType: BinanceSpotRest.Enums.OrderType._STOP_LOSS(),
      aboveStopPrice: Decimal.new("0.00129"),
      aboveTrailingDelta: 10,
      aboveClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      aboveStrategyId: 2,
      aboveStrategyType: 1_000_200
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
                   "aboveStopPrice=0.00129&" <>
                   "aboveStrategyId=2&" <>
                   "aboveStrategyType=1000200&" <>
                   "aboveTrailingDelta=10&" <>
                   "aboveType=STOP_LOSS&" <>
                   "belowClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "belowStopPrice=0.001&" <>
                   "belowStrategyId=2&" <>
                   "belowStrategyType=1000200&" <>
                   "belowTrailingDelta=10&" <>
                   "belowType=TAKE_PROFIT&" <>
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
    @required [:symbol, :quantity]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(AboveStopLossBelowTakeProfitQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (inclusive) (above):" do
    @inclusive [:aboveStopPrice, :aboveTrailingDelta]

    test "valid with one of [:aboveStopPrice, :aboveTrailingDelta]" do
      assert {:ok, %AboveStopLossBelowTakeProfitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 0))
               ~>> then(&struct(AboveStopLossBelowTakeProfitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %AboveStopLossBelowTakeProfitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 1))
               ~>> then(&struct(AboveStopLossBelowTakeProfitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:aboveStopPrice, :aboveTrailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(AboveStopLossBelowTakeProfitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (inclusive) (below):" do
    @inclusive [:belowStopPrice, :belowTrailingDelta]

    test "valid with one of [:belowStopPrice, :belowTrailingDelta]" do
      assert {:ok, %AboveStopLossBelowTakeProfitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 0))
               ~>> then(&struct(AboveStopLossBelowTakeProfitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %AboveStopLossBelowTakeProfitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 1))
               ~>> then(&struct(AboveStopLossBelowTakeProfitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:belowStopPrice, :belowTrailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(AboveStopLossBelowTakeProfitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (optional):" do
    @optional [
      :side,
      :listClientOrderId,
      :belowType,
      :belowClientOrderId,
      :belowStrategyId,
      :belowStrategyType,
      :aboveType,
      :aboveClientOrderId,
      :aboveStrategyId,
      :aboveStrategyType,
      :selfTradePreventionMode,
      :newOrderRespType,
      :recvWindow
    ]

    test "valid without optional fields" do
      assert {:ok, %AboveStopLossBelowTakeProfitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(AboveStopLossBelowTakeProfitQuery, &1))
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
      belowType: :TAKE_PROFIT_INVALID,
      belowStopPrice: "20.0",
      belowTrailingDelta: 10.5,
      belowClientOrderId: 1234,
      belowStrategyId: 2.4,
      belowStrategyType: "1_000_200",
      # ---
      aboveType: :STOP_LOSS_INVALID,
      aboveStopPrice: "20.0",
      aboveTrailingDelta: 10.5,
      aboveClientOrderId: 8910,
      aboveStrategyId: 2.4,
      aboveStrategyType: "1_000_200"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(AboveStopLossBelowTakeProfitQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation price compare" do
    test "error if aboveStopPrice is lower than belowStopPrice" do
      assert {:error, _} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:aboveStopPrice, Decimal.new("0.001"))
               ~>> Map.put(:belowStopPrice, Decimal.new("0.002"))
               ~>> then(&struct(AboveStopLossBelowTakeProfitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "error if aboveStopPrice is equal than belowStopPrice" do
      assert {:error, _} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:aboveStopPrice, Decimal.new("0.001"))
               ~>> Map.put(:belowStopPrice, Decimal.new("0.001"))
               ~>> then(&struct(AboveStopLossBelowTakeProfitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "ok if aboveStopPrice is greater than belowStopPrice" do
      assert {:ok, %AboveStopLossBelowTakeProfitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:aboveStopPrice, Decimal.new("0.002"))
               ~>> Map.put(:belowStopPrice, Decimal.new("0.001"))
               ~>> then(&struct(AboveStopLossBelowTakeProfitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
