defmodule BinanceSpotRest.Endpoints.Trading.SorOrderTestPost.MarketQuery do
  @moduledoc """
             Sor Order Test (post) - Market query

             """ <> BinanceSpotRest.Endpoints.Trading.SorOrderTestPost.Endpoint.moduledoc()

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Market.fields() ++
              BinanceSpotRest.Endpoints.Trading.SorOrderTestPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        # 'quoteOrderQty' is forbidden for SOR, and 'quantity' is exclusive with 'quoteOrderQty' for MARKET
        |> Valpa.decimal(:quantity)
        |> Valpa.value_of_values(:quoteOrderQty, [nil])
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Market.validation()
        |> BinanceSpotRest.Endpoints.Trading.SorOrderTestPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.SorOrderTestPost.Endpoint.metadata(),
        query: q
      }
  end
end
