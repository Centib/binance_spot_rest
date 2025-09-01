defmodule BinanceSpotRest.Endpoints.General.ExchangeInfo.SymbolsQuery do
  @moduledoc """
             Exchange Info - Symbols query

             """ <> BinanceSpotRest.Endpoints.General.ExchangeInfo.Endpoint.moduledoc()

  defstruct [:symbols, :showPermissionSets]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.uniq_list_of_type(:symbols, :string)
        |> Valpa.uniq_list_of_length(:symbols, %{min: 1, max: :infinity})
        |> Valpa.maybe_boolean(:showPermissionSets)

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.General.ExchangeInfo.Endpoint.metadata(),
        query: q
      }
  end
end
