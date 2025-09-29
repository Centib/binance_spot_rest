defmodule BinanceSpotRest.Endpoints.Account.OrderAmendmentsTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Account.OrderAmendments

  def full_valid_query do
    %OrderAmendments.Query{
      symbol: "LTCBTC",
      orderId: 1234,
      fromExecutionId: 5678,
      limit: 600,
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
                 "/api/v3/order/amendments?" <>
                   "fromExecutionId=5678&" <>
                   "limit=600&" <>
                   "orderId=1234&" <>
                   "recvWindow=3000.123&" <>
                   "symbol=LTCBTC&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }
    end
  end

  describe "validation (required):" do
    @required [:symbol, :orderId]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(OrderAmendments.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (optional):" do
    @optional [:fromExecutionId, :limit, :recvWindow]

    test "valid without optional fields" do
      assert {:ok, %OrderAmendments.Query{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(OrderAmendments.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (type):" do
    @bad_types [
      symbol: :LTCBTC,
      orderId: "1234",
      fromExecutionId: "5678",
      limit: "600",
      recvWindow: "3000"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(OrderAmendments.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end
end
