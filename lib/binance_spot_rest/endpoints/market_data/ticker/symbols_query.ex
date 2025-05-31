defmodule BinanceSpotRest.Endpoints.MarketData.Ticker.SymbolsQuery do
  @moduledoc """
  Symbols query
  """

  defstruct [:symbols, :windowSize, :type]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.uniq_list_of_type(:symbols, :string)
        |> Valpa.uniq_list_of_length(:symbols, %{min: 1, max: 100})
        |> Valpa.Custom.maybe_validator(:windowSize, BinanceSpotRest.Validators.WindowSize)
        |> Valpa.maybe_value_of_values(:type, BinanceSpotRest.Enums.Type.values())

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.Ticker.Endpoint.metadata(),
        query: q
      }
  end
end
