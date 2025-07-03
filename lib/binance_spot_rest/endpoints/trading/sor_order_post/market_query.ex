defmodule BinanceSpotRest.Endpoints.Trading.SorOrderPost.MarketQuery do
  @moduledoc """
  Sor order market query
  """

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Market.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        # 'quoteOrderQty' is forbidden for SOR, and 'quantity' is exclusive with 'quoteOrderQty' for MARKET
        |> Valpa.decimal(:quantity)
        |> Valpa.value_of_values(:quoteOrderQty, [nil])
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Market.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.SorOrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
