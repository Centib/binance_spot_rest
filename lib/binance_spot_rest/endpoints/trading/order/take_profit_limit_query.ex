defmodule BinanceSpotRest.Endpoints.Trading.Order.TakeProfitLimitQuery do
  @moduledoc """
  Take profit limit query
  """

  defstruct [type: BinanceSpotRest.Enums.OrderType._TAKE_PROFIT_LIMIT()] ++
              BinanceSpotRest.Endpoints.Trading.Order.SllTplCommon.fields() ++
              BinanceSpotRest.Endpoints.Trading.Order.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.value_of_values(:type, [BinanceSpotRest.Enums.OrderType._TAKE_PROFIT_LIMIT()])
        |> BinanceSpotRest.Endpoints.Trading.Order.SllTplCommon.validation()
        |> BinanceSpotRest.Endpoints.Trading.Order.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.Order.Endpoint.metadata(),
        query: q
      }
  end
end
