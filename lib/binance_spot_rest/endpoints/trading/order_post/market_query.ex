defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.MarketQuery do
  @moduledoc """
  Market query
  """

  defstruct [
              :symbol,
              :side,
              :quantity,
              :quoteOrderQty,
              type: BinanceSpotRest.Enums.OrderType._MARKET()
            ] ++ BinanceSpotRest.Endpoints.Trading.OrderPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.value_of_values(:type, [BinanceSpotRest.Enums.OrderType._MARKET()])
        |> Valpa.string(:symbol)
        |> Valpa.value_of_values(:side, BinanceSpotRest.Enums.Side.values())
        |> Valpa.map_exclusive_keys([:quantity, :quoteOrderQty])
        |> Valpa.maybe_decimal(:quantity)
        |> Valpa.maybe_decimal(:quoteOrderQty)
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
