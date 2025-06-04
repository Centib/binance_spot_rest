defmodule BinanceSpotRest.Endpoints.Trading.OrderDeleteTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Trading.OrderDelete

  def full_valid_query do
    %OrderCancel.Query{
      symbol: "LTCBTC",
      orderId: 61_031,
      origClientOrderId: "kkFw5yTj1JqZ5vu7PjPJ5S",
      newClientOrderId: "newClientOrderId",
      cancelRestrictions: BinanceSpotRest.Enums.CancelRestrictions._ONLY_PARTIALLY_FILLED(),
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
                 "/api/v3/order?" <>
                   "cancelRestrictions=ONLY_PARTIALLY_FILLED&" <>
                   "newClientOrderId=newClientOrderId&" <>
                   "orderId=61031&" <>
                   "origClientOrderId=kkFw5yTj1JqZ5vu7PjPJ5S&" <>
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
                 ~>> then(&struct(OrderCancel.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (optional):" do
    @optional [:newClientOrderId, :cancelRestrictions, :recvWindow]

    test "valid without optional fields" do
      assert {:ok, %OrderCancel.Query{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(OrderCancel.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (type):" do
    @bad_types [
      symbol: :LTCBTC,
      orderId: "61_031",
      origClientOrderId: 1234,
      newClientOrderId: 5678,
      cancelRestrictions: :ONLY_PARTIALLY_FILLED_INVALID,
      recvWindow: "3000"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(OrderCancel.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (inclusive):" do
    @inclusive [:orderId, :origClientOrderId]

    test "valid with one of #{inspect(@inclusive)}" do
      assert {:ok, %OrderCancel.Query{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:orderId)
               ~>> then(&struct(OrderCancel.Query, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %OrderCancel.Query{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.delete(:origClientOrderId)
               ~>> then(&struct(OrderCancel.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both #{inspect(@inclusive)} missing" do
      assert {:error, %{validator: :map_inclusive_keys, criteria: @inclusive}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@inclusive)
               ~>> then(&struct(OrderCancel.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
