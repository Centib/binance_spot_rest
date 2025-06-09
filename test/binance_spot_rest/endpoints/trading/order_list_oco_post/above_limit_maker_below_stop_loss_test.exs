defmodule BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.AboveLimitMakerBelowStopLossTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.AboveLimitMakerBelowStopLossQuery

  def full_valid_query do
    %AboveLimitMakerBelowStopLossQuery{
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
      belowType: BinanceSpotRest.Enums.OrderType._STOP_LOSS(),
      belowStopPrice: Decimal.new("20.0"),
      belowTrailingDelta: 10,
      belowClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      belowStrategyId: 2,
      belowStrategyType: 1_000_200
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
                   "belowStopPrice=20.0&" <>
                   "belowStrategyId=2&" <>
                   "belowStrategyType=1000200&" <>
                   "belowTrailingDelta=10&" <>
                   "belowType=STOP_LOSS&" <>
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
    @required [:symbol, :side, :quantity, :abovePrice]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(AboveLimitMakerBelowStopLossQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  # describe "validation (optional):" do
  #   @optional [
  #     :type,
  #     :newClientOrderId,
  #     :strategyId,
  #     :strategyType,
  #     :icebergQty,
  #     :selfTradePreventionMode,
  #     :newOrderRespType,
  #     :recvWindow
  #   ]

  #   test "valid without optional fields" do
  #     assert {:ok, %AboveLimitMakerBelowStopLossQuery{}} =
  #              full_valid_query()
  #              ~>> Map.from_struct()
  #              ~>> Map.drop(@optional)
  #              ~>> then(&struct(AboveLimitMakerBelowStopLossQuery, &1))
  #              ~>> BinanceSpotRest.Query.validate()
  #   end
  # end

  # describe "validation (type):" do
  #   @bad_types [
  #     symbol: :LTCBTC,
  #     side: :BUY_INVALID,
  #     type: :LIMIT_MAKER_INVALID,
  #     quantity: "1.0",
  #     price: "0.00129",
  #     newClientOrderId: 123,
  #     strategyId: 2.5,
  #     strategyType: "1_000_200",
  #     icebergQty: "0.5",
  #     selfTradePreventionMode: :EXPIRE_BOTH_INVALID,
  #     newOrderRespType: :ACK_INVALID,
  #     recvWindow: "3000"
  #   ]

  #   for {field, bad_value} <- @bad_types do
  #     test "invalid #{field} type" do
  #       assert {:error, %{field: unquote(field)}} =
  #                full_valid_query()
  #                ~>> Map.from_struct()
  #                ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
  #                ~>> then(&struct(AboveLimitMakerBelowStopLossQuery, &1))
  #                ~>> BinanceSpotRest.Query.validate()
  #     end
  #   end
  # end

  # describe "validation (specific):" do
  #   # No timeInForce is expected for LimitMaker orders – no test.

  #   test "incorrect icebergQty (not lower than quantity)" do
  #     assert {:error, %{field: :icebergQty}} =
  #              full_valid_query()
  #              ~>> Map.from_struct()
  #              ~>> Map.put(:icebergQty, Decimal.new("1.5"))
  #              ~>> then(&struct(AboveLimitMakerBelowStopLossQuery, &1))
  #              ~>> BinanceSpotRest.Query.validate()
  #   end
  # end
end
