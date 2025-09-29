defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.WorkingLimitPendingMarketTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.WorkingLimitPendingMarketQuery

  def full_valid_query do
    %WorkingLimitPendingMarketQuery{
      listClientOrderId: "2inzWQdDvZLHbbAmAozX2N",
      # ---
      symbol: "LTCBTC",
      selfTradePreventionMode: BinanceSpotRest.Enums.SelfTradePreventionMode._EXPIRE_BOTH(),
      newOrderRespType: BinanceSpotRest.Enums.NewOrderRespType._ACK(),
      recvWindow: Decimal.new("3000.123"),
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
      pendingSide: BinanceSpotRest.Enums.Side._BUY(),
      pendingType: BinanceSpotRest.Enums.OrderType._MARKET(),
      pendingQuantity: Decimal.new("0.002"),
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
                   "pendingQuantity=0.002&" <>
                   "pendingSide=BUY&" <>
                   "pendingStrategyId=2&" <>
                   "pendingStrategyType=1000200&" <>
                   "pendingType=MARKET&" <>
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
      :pendingSide,
      :pendingQuantity
    ]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(WorkingLimitPendingMarketQuery, &1))
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
      :pendingType,
      :pendingClientOrderId,
      :pendingStrategyId,
      :pendingStrategyType
    ]

    test "valid without optional fields" do
      assert {:ok, %WorkingLimitPendingMarketQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(WorkingLimitPendingMarketQuery, &1))
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
      pendingType: :MARKET_INVALID,
      pendingQuantity: "0.002",
      pendingClientOrderId: 9101,
      pendingStrategyId: 2.3,
      pendingStrategyType: "1_000_200"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(WorkingLimitPendingMarketQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (specific) (working):" do
    test "incorrect workingTimeInForce (FOC) when workingIcebergQty is set" do
      assert {:error, %{field: :workingTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:workingTimeInForce, BinanceSpotRest.Enums.TimeInForce._FOK())
               ~>> then(&struct(WorkingLimitPendingMarketQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect workingTimeInForce (IOC) when workingIcebergQty is set" do
      assert {:error, %{field: :workingTimeInForce}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:workingTimeInForce, BinanceSpotRest.Enums.TimeInForce._IOC())
               ~>> then(&struct(WorkingLimitPendingMarketQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "incorrect workingIcebergQty (not lower than quantity)" do
      assert {:error, %{field: :workingIcebergQty}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:workingIcebergQty, Decimal.new("1.5"))
               ~>> then(&struct(WorkingLimitPendingMarketQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (specific) (pending)" do
    test "invalid if :pendingQuoteOrderQty is not nil" do
      assert {:error,
              %{validator: :value_of_values, field: :pendingQuoteOrderQty, criteria: [nil]}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.put(:pendingQuoteOrderQty, Decimal.new("0.002"))
               ~>> then(&struct(WorkingLimitPendingMarketQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
