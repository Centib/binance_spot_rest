defmodule BinanceSpotRest.Endpoints.MarketData.TickerBookTicker.SymbolsQuery do
  @moduledoc """
             Ticker Book Ticker - Symbols query

             """ <> BinanceSpotRest.Endpoints.MarketData.TickerBookTicker.Endpoint.moduledoc()

  defstruct [:symbols]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.uniq_list_of_type(:symbols, :string)
        |> Valpa.uniq_list_of_length(:symbols, %{min: 1, max: :infinity})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.TickerBookTicker.Endpoint.metadata(),
        query: q
      }
  end
end
