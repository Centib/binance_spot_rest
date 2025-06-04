defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.TakeProfitQuery do
  @moduledoc """
  Take profit query
  """

  defstruct [type: BinanceSpotRest.Enums.OrderType._TAKE_PROFIT()] ++
              BinanceSpotRest.Endpoints.Trading.OrderPost.CommonSlTp.fields() ++
              BinanceSpotRest.Endpoints.Trading.OrderPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.value_of_values(:type, [BinanceSpotRest.Enums.OrderType._TAKE_PROFIT()])
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.CommonSlTp.validation()
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
