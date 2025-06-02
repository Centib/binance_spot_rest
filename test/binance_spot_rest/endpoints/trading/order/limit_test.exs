defmodule BinanceSpotRest.Endpoints.Trading.Order.LimitTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.Order

  def full_valid_query do
    %Order.LimitQuery{
      symbol: "LTCBTC",
      side: BinanceSpotRest.Enums.Side._BUY(),
      type: BinanceSpotRest.Enums.OrderType._LIMIT(),
      timeInForce: BinanceSpotRest.Enums.TimeInForce._GTC(),
      quantity: Decimal.new("1.0"),
      price: Decimal.new("0.00129"),
      newClientOrderId: "UsaAPevABCDE4LJ4oTobyX",
      strategyId: 2,
      strategyType: 1_000_200,
      icebergQty: Decimal.new("0.5"),
      selfTradePreventionMode: BinanceSpotRest.Enums.SelfTradePreventionMode._EXPIRE_BOTH(),
      newOrderRespType: BinanceSpotRest.Enums.NewOrderRespType._ACK(),
      recvWindow: 3000
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
                 "/api/v3/order?" <>
                   "icebergQty=0.5&" <>
                   "newClientOrderId=UsaAPevABCDE4LJ4oTobyX&" <>
                   "newOrderRespType=ACK&" <>
                   "price=0.00129&" <>
                   "quantity=1.0&" <>
                   "recvWindow=3000&" <>
                   "selfTradePreventionMode=EXPIRE_BOTH&" <>
                   "side=BUY&" <>
                   "strategyId=2&" <>
                   "strategyType=1000200&" <>
                   "symbol=LTCBTC&" <>
                   "timeInForce=GTC&" <>
                   "type=LIMIT&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }
    end
  end

  describe "validation (required):" do
    @required [:symbol, :side, :timeInForce, :quantity, :price]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(Order.LimitQuery, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (optional):" do
    @optional [
      :type,
      :newClientOrderId,
      :strategyId,
      :strategyType,
      :icebergQty,
      :selfTradePreventionMode,
      :newOrderRespType,
      :recvWindow
    ]

    test "valid without optional fields" do
      assert {:ok, %Order.LimitQuery{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(Order.LimitQuery, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (type):" do
    @bad_types [
      # should be string
      {:symbol, 123},
      # should be correct enum
      {:side, "BUY_SIDE"},
      # should be correct enum
      {:type, :LIMIT_MAKER},
      # should be correct enum
      {:timeInForce, :GTC_FORCE},
      # should be Decimal
      {:quantity, "not-a-decimal"},
      # should be Decimal
      {:price, nil},
      # should be string
      {:newClientOrderId, 123},
      # should be integer
      {:strategyId, "123"},
      # should be integer
      {:strategyType, 12.34},
      # should be Decimal
      {:icebergQty, "wrong"},
      # should be correct enum
      {:selfTradePreventionMode, :EXPIRE_BOTH_PREVENTION},
      # should be correct enum
      {:newOrderRespType, :ACK_RESPONSE},
      # should be integer
      {:recvWindow, "5000"}
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 |> Map.from_struct()
                 |> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 |> then(&struct(Order.LimitQuery, &1))
                 |> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (specific):" do
    test "incorrect timeInForce (FOC) when icebergQty is set" do
      assert {:error, %{field: :timeInForce}} =
               full_valid_query()
               |> Map.from_struct()
               |> Map.put(:timeInForce, BinanceSpotRest.Enums.TimeInForce._FOK())
               |> then(&struct(Order.LimitQuery, &1))
               |> BinanceSpotRest.Query.validate()
    end

    test "incorrect timeInForce (IOC) when icebergQty is set" do
      assert {:error, %{field: :timeInForce}} =
               full_valid_query()
               |> Map.from_struct()
               |> Map.put(:timeInForce, BinanceSpotRest.Enums.TimeInForce._IOC())
               |> then(&struct(Order.LimitQuery, &1))
               |> BinanceSpotRest.Query.validate()
    end

    test "incorrect icebergQty (not lower than quantity)" do
      assert {:error, %{field: :icebergQty}} =
               full_valid_query()
               |> Map.from_struct()
               |> Map.put(:icebergQty, Decimal.new("1.5"))
               |> then(&struct(Order.LimitQuery, &1))
               |> BinanceSpotRest.Query.validate()
    end
  end
end
