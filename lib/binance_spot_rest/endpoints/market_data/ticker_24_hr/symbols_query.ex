defmodule BinanceSpotRest.Endpoints.MarketData.Ticker24Hr.SymbolsQuery do
  @moduledoc """
             Ticker 24 Hr - Symbols query

             """ <> BinanceSpotRest.Endpoints.MarketData.Ticker24Hr.Endpoint.moduledoc()

  defstruct [:symbols, :type]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.uniq_list_of_type(:symbols, :string)
        |> Valpa.uniq_list_of_length(:symbols, %{min: 1, max: :infinity})
        |> Valpa.maybe_value_of_values(:type, BinanceSpotRest.Enums.Type.values())

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.Ticker24Hr.Endpoint.metadata(),
        query: q
      }
  end
end
