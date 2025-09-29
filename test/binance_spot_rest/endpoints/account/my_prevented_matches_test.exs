defmodule BinanceSpotRest.Endpoints.Account.MyPreventedMatchesTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Account.MyPreventedMatches

  def full_valid_query_with_prevented_match_id do
    %MyPreventedMatches.Query{
      symbol: "LTCBTC",
      preventedMatchId: 1234,
      recvWindow: Decimal.new("3000.123")
    }
  end

  def full_valid_query_with_order_id do
    %MyPreventedMatches.Query{
      symbol: "LTCBTC",
      orderId: 1234,
      fromPreventedMatchId: 5678,
      limit: 600,
      recvWindow: Decimal.new("3000.123")
    }
  end

  describe "request" do
    test "all params" do
      assert {:ok, request} =
               full_valid_query_with_prevented_match_id()
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
                 "/api/v3/myPreventedMatches?" <>
                   "preventedMatchId=1234&" <>
                   "recvWindow=3000.123&" <>
                   "symbol=LTCBTC&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }

      assert {:ok, request} =
               full_valid_query_with_order_id()
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
                 "/api/v3/myPreventedMatches?" <>
                   "fromPreventedMatchId=5678&" <>
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
    @required [:symbol]

    for field <- @required do
      test "invalid without #{field}" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query_with_prevented_match_id()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(MyPreventedMatches.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()

        assert {:error, %{field: unquote(field)}} =
                 full_valid_query_with_order_id()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(MyPreventedMatches.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (optional):" do
    @optional_with_prevented_match_id [:recvWindow]

    @optional_with_order_id [:fromPreventedMatchId, :limit, :recvWindow]

    test "valid without optional fields" do
      assert {:ok, %MyPreventedMatches.Query{}} =
               full_valid_query_with_prevented_match_id()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional_with_prevented_match_id)
               ~>> then(&struct(MyPreventedMatches.Query, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %MyPreventedMatches.Query{}} =
               full_valid_query_with_order_id()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional_with_order_id)
               ~>> then(&struct(MyPreventedMatches.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (type):" do
    @bad_types_with_prevented_match_id [
      symbol: :LTCBTC,
      preventedMatchId: "1234",
      recvWindow: "3000"
    ]

    @bad_types_with_order_id [
      orderId: "1234",
      fromPreventedMatchId: "5678",
      limit: "600"
    ]

    for {field, bad_value} <- @bad_types_with_prevented_match_id do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query_with_prevented_match_id()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(MyPreventedMatches.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end

    for {field, bad_value} <- @bad_types_with_order_id do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query_with_order_id()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(MyPreventedMatches.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (exclusive keys):" do
    test "invalid if preventedMatchId is with orderId" do
      assert {:error, %{validator: :map_exclusive_keys}} =
               %MyPreventedMatches.Query{
                 symbol: "LTCBTC",
                 preventedMatchId: 1234,
                 orderId: 5678,
                 recvWindow: Decimal.new("3000.123")
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if both preventedMatchId and orderId is missing" do
      assert {:error, %{validator: :map_exclusive_keys}} =
               %MyPreventedMatches.Query{
                 symbol: "LTCBTC",
                 recvWindow: Decimal.new("3000.123")
               }
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (exclusive optional keys):" do
    test "invalid if preventedMatchId is with fromPreventedMatchId and limit" do
      assert {:error, %{validator: :map_exclusive_optional_keys}} =
               %MyPreventedMatches.Query{
                 symbol: "LTCBTC",
                 preventedMatchId: 1234,
                 fromPreventedMatchId: 5678,
                 limit: 600,
                 recvWindow: Decimal.new("3000.123")
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if preventedMatchId is with fromPreventedMatchId" do
      assert {:error, %{validator: :map_exclusive_optional_keys}} =
               %MyPreventedMatches.Query{
                 symbol: "LTCBTC",
                 preventedMatchId: 1234,
                 fromPreventedMatchId: 5678,
                 recvWindow: Decimal.new("3000.123")
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if preventedMatchId is with limit" do
      assert {:error, %{validator: :map_exclusive_optional_keys}} =
               %MyPreventedMatches.Query{
                 symbol: "LTCBTC",
                 preventedMatchId: 1234,
                 limit: 600,
                 recvWindow: Decimal.new("3000.123")
               }
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
