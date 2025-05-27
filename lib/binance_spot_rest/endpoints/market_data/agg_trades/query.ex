defmodule BinanceSpotRest.Endpoints.MarketData.AggTrades.Query do
  @moduledoc """
  AggTrades.Query
  """

  defstruct [:symbol, :fromId, :startTime, :endTime, :limit]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.map_exclusive_optional_keys([:fromId, :startTime])
        |> Valpa.map_exclusive_optional_keys([:fromId, :endTime])
        |> Valpa.maybe_integer(:fromId)
        |> Valpa.maybe_integer(:startTime)
        |> Valpa.maybe_integer(:endTime)
        |> Valpa.maybe_integer_in_range(:limit, %{min: 1, max: 1000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.AggTrades.Endpoint.metadata(),
        query: q
      }
  end
end
