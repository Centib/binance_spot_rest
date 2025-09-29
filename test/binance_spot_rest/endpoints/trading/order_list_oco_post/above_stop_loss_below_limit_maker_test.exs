defmodule BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.AboveStopLossBelowLimitMakerTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.AboveStopLossBelowLimitMakerQuery

  def full_valid_query do
    %AboveStopLossBelowLimitMakerQuery{
      listClientOrderId: "2inzWQdDvZLHbbAmAozX2N",
      # ---
      symbol: "LTCBTC",
      side: BinanceSpotRest.Enums.Side._BUY(),
      quantity: Decimal.new("1.0"),
      selfTradePreventionMode: BinanceSpotRest.Enums.SelfTradePreventionMode._EXPIRE_BOTH(),
      newOrderRespType: BinanceSpotRest.Enums.NewOrderRespType._ACK(),
      recvWindow: Decimal.new("3000.123"),
      # ---
      belowType: BinanceSpotRest.Enums.OrderType._LIMIT_MAKER(),
      belowPrice: Decimal.new("0.001"),
      belowClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      belowStrategyId: 2,
      belowStrategyType: 1_000_200,
      belowIcebergQty: Decimal.new("0.5"),
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
                   "belowIcebergQty=0.5&" <>
                   "belowPrice=0.001&" <>
                   "belowStrategyId=2&" <>
                   "belowStrategyType=1000200&" <>
                   "belowType=LIMIT_MAKER&" <>
                   "listClientOrderId=2inzWQdDvZLHbbAmAozX2N&" <>
                   "newOrderRespType=ACK&" <>
                   "quantity=1.0&" <>
                   "recvWindow=3000.123&" <>
                   "selfTradePreventionMode=EXPIRE_BOTH&" <>
                   "side=BUY&" <>
                   "symbol=LTCBTC&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }
    end
  end

  describe "validation (required):" do
    @required [:symbol, :quantity, :belowPrice]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(AboveStopLossBelowLimitMakerQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (inclusive):" do
    @inclusive [:aboveStopPrice, :aboveTrailingDelta]

    test "valid with one of [:aboveStopPrice, :aboveTrailingDelta]" do
      assert {:ok, %AboveStopLossBelowLimitMakerQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 0))
               ~>> then(&struct(AboveStopLossBelowLimitMakerQuery, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %AboveStopLossBelowLimitMakerQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 1))
               ~>> then(&struct(AboveStopLossBelowLimitMakerQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:aboveStopPrice, :aboveTrailingDelta] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(AboveStopLossBelowLimitMakerQuery, &1))
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
      :belowIcebergQty,
      :aboveType,
      :aboveClientOrderId,
      :aboveStrategyId,
      :aboveStrategyType,
      :selfTradePreventionMode,
      :newOrderRespType,
      :recvWindow
    ]

    test "valid without optional fields" do
      assert {:ok, %AboveStopLossBelowLimitMakerQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(AboveStopLossBelowLimitMakerQuery, &1))
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
      belowType: :LIMIT_MAKER_INVALID,
      belowPrice: "0.00129",
      belowClientOrderId: 4567,
      belowStrategyId: 2.5,
      belowStrategyType: "1_000_200",
      belowIcebergQty: "0.5",
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
                 ~>> then(&struct(AboveStopLossBelowLimitMakerQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (specific):" do
    # No timeInForce is expected for LimitMaker orders – no test.

    test "incorrect belowIcebergQty (not lower than quantity)" do
      assert {:error, %{field: :belowIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:belowIcebergQty, Decimal.new("1.5"))
               ~>> then(&struct(AboveStopLossBelowLimitMakerQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation price compare" do
    test "error if aboveStopPrice is lower than belowPrice" do
      assert {:error, _} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:aboveStopPrice, Decimal.new("0.001"))
               ~>> Map.put(:belowPrice, Decimal.new("0.002"))
               ~>> then(&struct(AboveStopLossBelowLimitMakerQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "error if aboveStopPrice is equal than belowPrice" do
      assert {:error, _} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:aboveStopPrice, Decimal.new("0.001"))
               ~>> Map.put(:belowPrice, Decimal.new("0.001"))
               ~>> then(&struct(AboveStopLossBelowLimitMakerQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "ok if aboveStopPrice is greater than belowPrice" do
      assert {:ok, %AboveStopLossBelowLimitMakerQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:aboveStopPrice, Decimal.new("0.002"))
               ~>> Map.put(:belowPrice, Decimal.new("0.001"))
               ~>> then(&struct(AboveStopLossBelowLimitMakerQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
