defmodule BinanceSpotRest.Endpoints.MarketData.TickerPrice.SymbolsQuery do
  @moduledoc """
             Ticker Price - Symbols query
             """ <> BinanceSpotRest.Endpoints.MarketData.TickerPrice.Endpoint.moduledoc()

  defstruct [:symbols]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.uniq_list_of_type(:symbols, :string)
        |> Valpa.uniq_list_of_length(:symbols, %{min: 1, max: :infinity})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.TickerPrice.Endpoint.metadata(),
        query: q
      }
  end
end
