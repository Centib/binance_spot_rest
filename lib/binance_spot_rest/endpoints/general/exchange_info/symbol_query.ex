defmodule BinanceSpotRest.Endpoints.General.ExchangeInfo.SymbolQuery do
  @moduledoc """
  Symbol query
  """

  defstruct [:symbol, :showPermissionSets]

  defimpl BinanceSpotRest.Query do
    def validate(%BinanceSpotRest.Endpoints.General.ExchangeInfo.SymbolQuery{} = q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.maybe_boolean(:showPermissionSets)

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.General.ExchangeInfo.Endpoint.metadata(),
        query: q
      }
  end
end
