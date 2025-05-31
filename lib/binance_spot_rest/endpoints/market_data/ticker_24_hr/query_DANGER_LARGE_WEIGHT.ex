defmodule BinanceSpotRest.Endpoints.MarketData.Ticker24Hr.Query_DANGER_LARGE_WEIGHT do
  @moduledoc """
  Query without specify symbol. Weight is 80!
  """

  defstruct [:type]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.maybe_value_of_values(:type, BinanceSpotRest.Enums.Type.values())

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.MarketData.Ticker24Hr.Endpoint.metadata(),
        query: q
      }
  end
end
