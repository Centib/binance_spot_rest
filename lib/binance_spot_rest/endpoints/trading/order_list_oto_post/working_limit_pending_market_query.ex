defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.WorkingLimitPendingMarketQuery do
  @moduledoc """
             Order List Oto (post) - Working limit pending market query

             """ <> BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.Endpoint.moduledoc()

  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Limit, as: Working
  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Market, as: Pending

  defstruct BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.UseShared.fields(Working, Pending) ++
              BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        # 'quoteOrderQty' is forbidden for OTO, and 'quantity' is exclusive with 'quoteOrderQty' for MARKET
        |> Valpa.decimal(:pendingQuantity)
        |> Valpa.value_of_values(:pendingQuoteOrderQty, [nil])
        |> BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.UseShared.validation(
          Working,
          Pending
        )
        |> BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.Endpoint.metadata(),
        query: q
      }
  end
end
