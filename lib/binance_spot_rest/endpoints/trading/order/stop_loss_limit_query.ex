defmodule BinanceSpotRest.Endpoints.Trading.Order.StopLossLimitQuery do
  @moduledoc """
  Stop loss limit query
  """

  defstruct [type: BinanceSpotRest.Enums.OrderType._STOP_LOSS_LIMIT()] ++
              BinanceSpotRest.Endpoints.Trading.Order.CommonSllTpl.fields() ++
              BinanceSpotRest.Endpoints.Trading.Order.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.value_of_values(:type, [BinanceSpotRest.Enums.OrderType._STOP_LOSS_LIMIT()])
        |> BinanceSpotRest.Endpoints.Trading.Order.CommonSllTpl.validation()
        |> BinanceSpotRest.Endpoints.Trading.Order.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.Order.Endpoint.metadata(),
        query: q
      }
  end
end
