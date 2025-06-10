defmodule BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.AboveLimitMakerBelowStopLossLimitTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.AboveLimitMakerBelowStopLossLimitQuery

  def full_valid_query do
    %AboveLimitMakerBelowStopLossLimitQuery{
      listClientOrderId: "2inzWQdDvZLHbbAmAozX2N",
      # ---
      symbol: "LTCBTC",
      side: BinanceSpotRest.Enums.Side._BUY(),
      quantity: Decimal.new("1.0"),
      selfTradePreventionMode: BinanceSpotRest.Enums.SelfTradePreventionMode._EXPIRE_BOTH(),
      newOrderRespType: BinanceSpotRest.Enums.NewOrderRespType._ACK(),
      recvWindow: 3000,
      # ---
      aboveType: BinanceSpotRest.Enums.OrderType._LIMIT_MAKER(),
      abovePrice: Decimal.new("0.00129"),
      aboveClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      aboveStrategyId: 2,
      aboveStrategyType: 1_000_200,
      aboveIcebergQty: Decimal.new("0.5"),
      # ---
      belowType: BinanceSpotRest.Enums.OrderType._STOP_LOSS_LIMIT(),
      belowTimeInForce: BinanceSpotRest.Enums.TimeInForce._GTC(),
      belowPrice: Decimal.new("0.00129"),
      belowStopPrice: Decimal.new("0.001"),
      belowTrailingDelta: 10,
      belowClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      belowStrategyId: 2,
      belowStrategyType: 1_000_200,
      belowIcebergQty: Decimal.new("0.5")
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
                   "aboveStrategyId=2&" <>
                   "aboveStrategyType=1000200&" <>
                   "aboveType=LIMIT_MAKER&" <>
                   "belowClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "belowIcebergQty=0.5&" <>
                   "belowPrice=0.00129&" <>
                   "belowStopPrice=0.001&" <>
                   "belowStrategyId=2&" <>
                   "belowStrategyType=1000200&" <>
                   "belowTimeInForce=GTC&" <>
                   "belowTrailingDelta=10&" <>
                   "belowType=STOP_LOSS_LIMIT&" <>
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
    @required [:symbol, :side, :quantity, :abovePrice, :belowTimeInForce, :belowPrice]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(AboveLimitMakerBelowStopLossLimitQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (inclusive):" do
    @inclusive [:belowStopPrice, :belowTrailingDelta]

    test "valid with one of [:belowStopPrice, :belowTrailingDelta]" do
      assert {:ok, %AboveLimitMakerBelowStopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 0))
               ~>> then(&struct(AboveLimitMakerBelowStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %AboveLimitMakerBelowStopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 1))
               ~>> then(&struct(AboveLimitMakerBelowStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:belowStopPrice, :belowTrailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(AboveLimitMakerBelowStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (optional):" do
    @optional [
      :listClientOrderId,
      :aboveType,
      :aboveClientOrderId,
      :aboveStrategyId,
      :aboveStrategyType,
      :aboveIcebergQty,
      :belowType,
      :belowClientOrderId,
      :belowStrategyId,
      :belowStrategyType,
      :belowIcebergQty,
      :selfTradePreventionMode,
      :newOrderRespType,
      :recvWindow
    ]

    test "valid without optional fields" do
      assert {:ok, %AboveLimitMakerBelowStopLossLimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(AboveLimitMakerBelowStopLossLimitQuery, &1))
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
      aboveType: :LIMIT_MAKER_INVALID,
      abovePrice: "0.00129",
      aboveClientOrderId: 4567,
      aboveStrategyId: 2.5,
      aboveStrategyType: "1_000_200",
      aboveIcebergQty: "0.5",
      # ---
      belowType: :STOP_LOSS_LIMIT_INVALID,
      belowTimeInForce: :GTC_INVALID,
      belowPrice: "0.00129",
      belowStopPrice: "0.001",
      belowTrailingDelta: 10.5,
      belowClientOrderId: 1234,
      belowStrategyId: 2.5,
      belowStrategyType: "1_000_200",
      belowIcebergQty: "0.5"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(AboveLimitMakerBelowStopLossLimitQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (specific) (above):" do
    # No timeInForce is expected for LimitMaker orders – no test.

    test "incorrect aboveIcebergQty (not lower than quantity)" do
      assert {:error, %{field: :aboveIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:aboveIcebergQty, Decimal.new("1.5"))
               ~>> then(&struct(AboveLimitMakerBelowStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (specific) (below):" do
    test "incorrect belowTimeInForce (FOC) when belowIcebergQty is set" do
      assert {:error, %{field: :belowTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:belowTimeInForce, BinanceSpotRest.Enums.TimeInForce._FOK())
               ~>> then(&struct(AboveLimitMakerBelowStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect belowTimeInForce (IOC) when belowIcebergQty is set" do
      assert {:error, %{field: :belowTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:belowTimeInForce, BinanceSpotRest.Enums.TimeInForce._IOC())
               ~>> then(&struct(AboveLimitMakerBelowStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect belowIcebergQty (not lower than quantity)" do
      assert {:error, %{field: :belowIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:belowIcebergQty, Decimal.new("1.5"))
               ~>> then(&struct(AboveLimitMakerBelowStopLossLimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
