defmodule BinanceSpotRest.Endpoints.Trading.Order.LimitQuery do
  @moduledoc """
  Limit query
  """

  defstruct [
              :symbol,
              :side,
              :timeInForce,
              :quantity,
              :price,
              :icebergQty,
              type: BinanceSpotRest.Enums.OrderType._LIMIT()
            ] ++ BinanceSpotRest.Endpoints.Trading.Order.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.value_of_values(:type, [BinanceSpotRest.Enums.OrderType._LIMIT()])
        |> Valpa.string(:symbol)
        |> Valpa.value_of_values(:side, BinanceSpotRest.Enums.Side.values())
        |> Valpa.value_of_values(:timeInForce, BinanceSpotRest.Enums.TimeInForce.values())
        |> Valpa.decimal(:quantity)
        |> Valpa.decimal(:price)
        |> Valpa.Custom.validator(BinanceSpotRest.Validators.IcebergQty)
        |> BinanceSpotRest.Endpoints.Trading.Order.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.Order.Endpoint.metadata(),
        query: q
      }
  end
end
