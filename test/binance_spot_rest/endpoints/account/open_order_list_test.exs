defmodule BinanceSpotRest.Endpoints.Account.OpenOrderListTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Loe

  alias BinanceSpotRest.Endpoints.Account.OpenOrderList

  def full_valid_query do
    %OpenOrderList.Query{
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
               method: BinanceSpotRest.Enums.Method._get(),
               headers: [{"FAKE_API_KEY", "fake1234api5678key"}],
               base_url: "https://fake.binance.url",
               url:
                 "/api/v3/openOrderList?" <>
                   "recvWindow=3000&" <>
                   "timestamp=1740587673449&" <>
                   "signature=fake_signature"
             }
    end
  end

  describe "validation (optional):" do
    @optional [:recvWindow]

    test "valid without optional fields" do
      assert {:ok, %OpenOrderList.Query{}} =
               full_valid_query()
               ~>> Map.from_struct()
               ~>> Map.drop(@optional)
               ~>> then(&struct(OpenOrderList.Query, &1))
               ~>> BinanceSpotRest.Query.validate()
    end
  end

  describe "validation (type):" do
    @bad_types [
      recvWindow: "3000"
    ]

    for {field, bad_value} <- @bad_types do
      test "invalid #{field} type" do
        assert {:error, %{field: unquote(field)}} =
                 full_valid_query()
                 ~>> Map.from_struct()
                 ~>> Map.put(unquote(field), unquote(Macro.escape(bad_value)))
                 ~>> then(&struct(OpenOrderList.Query, &1))
                 ~>> BinanceSpotRest.Query.validate()
      end
    end
  end
end
