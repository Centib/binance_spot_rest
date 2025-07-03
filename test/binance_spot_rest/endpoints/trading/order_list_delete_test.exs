defmodule BinanceSpotRest.Endpoints.Trading.OrderListDeleteTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderListDelete

  def full_valid_query do
    %OrderListDelete.Query{
      symbol: "LTCBTC",
      orderListId: 1234,
      listClientOrderId: "listClientOrderId",
      newClientOrderId: "newClientOrderId",
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
               method: BinanceSpotRest.Enums.Method._delete(),
               headers: [{"FAKE_API_KEY", "fake1234api5678key"}],
               base_url: "https://fake.binance.url",
               url:
                 "/api/v3/orderList?" <>
                   "listClientOrderId=listClientOrderId&" <>
                   "newClientOrderId=newClientOrderId&" <>
                   "orderListId=1234&" <>
                   "recvWindow=3000&" <>
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
                 ~>> then(&struct(OrderListDelete.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (optional):" do
    @optional [:recvWindow, :newClientOrderId, :recvWindow]

    test "valid without optional fields" do
      assert {:ok, %OrderListDelete.Query{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(OrderListDelete.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (inclusive):" do
    @inclusive [:orderListId, :listClientOrderId]

    test "valid with one of [:orderListId, :listClientOrderId]" do
      assert {:ok, %OrderListDelete.Query{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 0))
               ~>> then(&struct(OrderListDelete.Query, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %OrderListDelete.Query{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(Enum.at(@inclusive, 1))
               ~>> then(&struct(OrderListDelete.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both [:orderListId, :listClientOrderId] missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(OrderListDelete.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (type):" do
    @bad_types [
      symbol: :LTCBTC,
      orderListId: "1234",
      listClientOrderId: 1234,
      newClientOrderId: 5678,
      recvWindow: "3000"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(OrderListDelete.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end
end
