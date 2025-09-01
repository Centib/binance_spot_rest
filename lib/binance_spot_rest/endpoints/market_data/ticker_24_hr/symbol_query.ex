defmodule BinanceSpotRest.Endpoints.MarketData.Ticker24Hr.SymbolQuery do
  @moduledoc """
             Ticker 24 Hr - Symbol query
             """ <> BinanceSpotRest.Endpoints.MarketData.Ticker24Hr.Endpoint.moduledoc()

  defstruct [:symbol, :type]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.maybe_value_of_values(:type, BinanceSpotRest.Enums.Type.values())

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.Ticker24Hr.Endpoint.metadata(),
        query: q
      }
  end
end
