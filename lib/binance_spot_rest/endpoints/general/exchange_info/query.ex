defmodule BinanceSpotRest.Endpoints.General.ExchangeInfo.Query do
  @moduledoc """
             Exchange Info - Permissions and status query
             """ <> BinanceSpotRest.Endpoints.General.ExchangeInfo.Endpoint.moduledoc()

  defstruct [:permissions, :showPermissionSets, :symbolStatus]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.maybe_value_or_uniq_list_of_values(
          :permissions,
          BinanceSpotRest.Enums.Permission.values()
        )
        |> Valpa.maybe_boolean(:showPermissionSets)
        |> Valpa.maybe_value_of_values(:symbolStatus, BinanceSpotRest.Enums.SymbolStatus.values())

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.General.ExchangeInfo.Endpoint.metadata(),
        query: q
      }
  end
end
