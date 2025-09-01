defmodule BinanceSpotRest.Endpoints.MarketData.TickerTradingDay.SymbolQuery do
  @moduledoc """
             Ticker Trading Day - Symbol query
             """ <> BinanceSpotRest.Endpoints.MarketData.TickerTradingDay.Endpoint.moduledoc()

  defstruct [:symbol, :timeZone, :type]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.Custom.maybe_validator(:timeZone, BinanceSpotRest.Validators.TimeZone)
        |> Valpa.maybe_value_of_values(:type, BinanceSpotRest.Enums.Type.values())

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.TickerTradingDay.Endpoint.metadata(),
        query: q
      }
  end
end
