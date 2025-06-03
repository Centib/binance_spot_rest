defmodule BinanceSpotRest.Endpoints.Trading.Order.TakeProfitQuery do
  @moduledoc """
  Take profit query
  """

  defstruct [type: BinanceSpotRest.Enums.OrderType._TAKE_PROFIT()] ++
              BinanceSpotRest.Endpoints.Trading.Order.CommonSlTp.fields() ++
              BinanceSpotRest.Endpoints.Trading.Order.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.value_of_values(:type, [BinanceSpotRest.Enums.OrderType._TAKE_PROFIT()])
        |> BinanceSpotRest.Endpoints.Trading.Order.CommonSlTp.validation()
        |> BinanceSpotRest.Endpoints.Trading.Order.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.Order.Endpoint.metadata(),
        query: q
      }
  end
end
