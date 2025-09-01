defmodule BinanceSpotRest.Endpoints.MarketData.TickerTradingDay.SymbolsQuery do
  @moduledoc """
             Ticker Trading Day - Symbols query
             """ <> BinanceSpotRest.Endpoints.MarketData.TickerTradingDay.Endpoint.moduledoc()

  defstruct [:symbols, :timeZone, :type]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.uniq_list_of_type(:symbols, :string)
        |> Valpa.uniq_list_of_length(:symbols, %{min: 1, max: 100})
        |> Valpa.Custom.maybe_validator(:timeZone, BinanceSpotRest.Validators.TimeZone)
        |> Valpa.maybe_value_of_values(:type, BinanceSpotRest.Enums.Type.values())

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.TickerTradingDay.Endpoint.metadata(),
        query: q
      }
  end
end
