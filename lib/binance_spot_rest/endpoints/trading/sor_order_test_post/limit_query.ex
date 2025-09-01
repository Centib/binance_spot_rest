defmodule BinanceSpotRest.Endpoints.Trading.SorOrderTestPost.LimitQuery do
  @moduledoc """
             Sor Order Test (post) - Limit query

             """ <> BinanceSpotRest.Endpoints.Trading.SorOrderTestPost.Endpoint.moduledoc()

  defstruct BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Limit.fields() ++
              BinanceSpotRest.Endpoints.Trading.SorOrderTestPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Limit.validation()
        |> BinanceSpotRest.Endpoints.Trading.SorOrderTestPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.SorOrderTestPost.Endpoint.metadata(),
        query: q
      }
  end
end
