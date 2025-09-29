defmodule BinanceSpotRest.Endpoints.Account.OrderTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Account.Order

  def full_valid_query do
    %Order.Query{
      symbol: "LTCBTC",
      orderId: 1234,
      origClientOrderId: "origClientOrderId",
      recvWindow: Decimal.new("3000.123")
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
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [{"FAKE_API_KEY", "fake1234api5678key"}],
               base_url: "https://fake.binance.url",
               url:
                 "/api/v3/order?" <>
                   "orderId=1234&" <>
                   "origClientOrderId=origClientOrderId&" <>
                   "recvWindow=3000.123&" <>
                   "symbol=LTCBTC&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }
    end
  end

  describe "validation (required):" do
    @required [:symbol]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(Order.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (optional):" do
    @optional [:recvWindow]

    test "valid without optional fields" do
      assert {:ok, %Order.Query{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(Order.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (type):" do
    @bad_types [
      symbol: :LTCBTC,
      orderId: "1234",
      origClientOrderId: 5678,
      recvWindow: "3000"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(Order.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (inclusive):" do
    @inclusive [:orderId, :origClientOrderId]

    test "valid with one of #{inspect(@inclusive)}" do
      assert {:ok, %Order.Query{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:orderId)
               ~>> then(&struct(Order.Query, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %Order.Query{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:origClientOrderId)
               ~>> then(&struct(Order.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both #{inspect(@inclusive)} missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(Order.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
