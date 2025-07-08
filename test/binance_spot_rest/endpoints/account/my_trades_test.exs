defmodule BinanceSpotRest.Endpoints.Account.MyTradesTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Account.MyTrades

  def full_valid_query_basic do
    %MyTrades.Query{
      symbol: "LTCBTC",
      limit: 600,
      recvWindow: 3000
    }
  end

  def full_valid_query_with_ids do
    %MyTrades.Query{
      symbol: "LTCBTC",
      orderId: 1234,
      fromId: 5678,
      limit: 600,
      recvWindow: 3000
    }
  end

  def full_valid_query_with_times do
    %MyTrades.Query{
      symbol: "LTCBTC",
      startTime: 1_751_624_374_960,
      endTime: 1_751_624_974_980,
      limit: 600,
      recvWindow: 3000
    }
  end

  describe "request" do
    test "all params" do
      assert {:ok, request} =
               full_valid_query_basic()
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
                 "/api/v3/myTrades?" <>
                   "limit=600&" <>
                   "recvWindow=3000&" <>
                   "symbol=LTCBTC&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }

      assert {:ok, request} =
               full_valid_query_with_ids()
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
                 "/api/v3/myTrades?" <>
                   "fromId=5678&" <>
                   "limit=600&" <>
                   "orderId=1234&" <>
                   "recvWindow=3000&" <>
                   "symbol=LTCBTC&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }

      assert {:ok, request} =
               full_valid_query_with_times()
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
                 "/api/v3/myTrades?" <>
                   "endTime=1751624974980&" <>
                   "limit=600&" <>
                   "recvWindow=3000&" <>
                   "startTime=1751624374960&" <>
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
                 full_valid_query_basic()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(MyTrades.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()

        assert {:error, %{field: unquote(field)}} =
                 full_valid_query_with_ids()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(MyTrades.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()

        assert {:error, %{field: unquote(field)}} =
                 full_valid_query_with_times()
                 ~>> Map.from_struct()
                 ~>> Map.delete(unquote(field))
                 ~>> then(&struct(MyTrades.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (optional):" do
    @optional_basic [:limit, :recvWindow]

    @optional_with_ids [:orderId, :fromId, :limit, :recvWindow]

    @optional_with_times [:startTime, :endTime, :limit, :recvWindow]

    test "valid without optional fields" do
      assert {:ok, %MyTrades.Query{}} =
               full_valid_query_basic()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional_basic)
               ~>> then(&struct(MyTrades.Query, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %MyTrades.Query{}} =
               full_valid_query_with_ids()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional_with_ids)
               ~>> then(&struct(MyTrades.Query, &1))
               ~>> BinanceSpotRest.Query.validate()

      assert {:ok, %MyTrades.Query{}} =
               full_valid_query_with_times()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional_with_times)
               ~>> then(&struct(MyTrades.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (type):" do
    @bad_types_basic [
      symbol: :LTCBTC,
      limit: "600",
      recvWindow: "3000"
    ]

    @bad_types_with_ids [
      orderId: "1234",
      fromId: "5678"
    ]

    @bad_types_with_times [
      startTime: "1_751_624_374_960",
      endTime: "1_751_624_974_980"
    ]

    for {field, bad_value} <- @bad_types_basic do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query_basic()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(MyTrades.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end

    for {field, bad_value} <- @bad_types_with_ids do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query_with_ids()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(MyTrades.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end

    for {field, bad_value} <- @bad_types_with_times do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query_with_times()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(MyTrades.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end

  describe "validation (exclusive optional keys):" do
    test "invalid if orderId is with startTime and endTime" do
      assert {:error, %{validator: :map_exclusive_optional_keys}} =
               %MyTrades.Query{
                 symbol: "LTCBTC",
                 orderId: 1234,
                 startTime: 1_751_624_374_960,
                 endTime: 1_751_624_974_980
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if orderId is with startTime" do
      assert {:error, %{validator: :map_exclusive_optional_keys}} =
               %MyTrades.Query{
                 symbol: "LTCBTC",
                 orderId: 1234,
                 startTime: 1_751_624_374_960
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if orderId is with endTime" do
      assert {:error, %{validator: :map_exclusive_optional_keys}} =
               %MyTrades.Query{
                 symbol: "LTCBTC",
                 orderId: 1234,
                 endTime: 1_751_624_974_980
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if fromId is with startTime and endTime" do
      assert {:error, %{validator: :map_exclusive_optional_keys}} =
               %MyTrades.Query{
                 symbol: "LTCBTC",
                 fromId: 1234,
                 startTime: 1_751_624_374_960,
                 endTime: 1_751_624_974_980
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if fromId is with startTime" do
      assert {:error, %{validator: :map_exclusive_optional_keys}} =
               %MyTrades.Query{
                 symbol: "LTCBTC",
                 fromId: 1234,
                 startTime: 1_751_624_374_960
               }
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid if fromId is with endTime" do
      assert {:error, %{validator: :map_exclusive_optional_keys}} =
               %MyTrades.Query{
                 symbol: "LTCBTC",
                 fromId: 1234,
                 endTime: 1_751_624_974_980
               }
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (time range):" do
    test "invalid startTime endTime interval" do
      assert {:error, %{validator: :timeRange24h, criteria: %{limit_ms: 86_400_000}}} =
               full_valid_query_with_times()
               ~>> Map.from_struct()
               ~>> Map.put(:startTime, 1_751_424_374_960)
               ~>> Map.put(:endTime, 1_751_624_974_980)
               ~>> then(&struct(MyTrades.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end

    test "invalid startTime endTime relation" do
      assert {:error, %{validator: :timeRange24h, criteria: %{comparison: :start_before_end}}} =
               full_valid_query_with_times()
               ~>> Map.from_struct()
               ~>> Map.put(:startTime, 1_751_624_974_980)
               ~>> Map.put(:endTime, 1_751_624_374_960)
               ~>> then(&struct(MyTrades.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end
end
