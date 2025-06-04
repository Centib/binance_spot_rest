defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.TakeProfitLimitQuery do
  @moduledoc """
  Take profit limit query
  """

  defstruct [type: BinanceSpotRest.Enums.OrderType._TAKE_PROFIT_LIMIT()] ++
              BinanceSpotRest.Endpoints.Trading.OrderPost.CommonSllTpl.fields() ++
              BinanceSpotRest.Endpoints.Trading.OrderPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.value_of_values(:type, [BinanceSpotRest.Enums.OrderType._TAKE_PROFIT_LIMIT()])
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.CommonSllTpl.validation()
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
