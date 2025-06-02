defmodule BinanceSpotRest.Endpoints.Trading.Order.LimitMakerQuery do
  @moduledoc """
  Limit maker query
  """

  defstruct [
              :symbol,
              :side,
              :quantity,
              :price,
              :icebergQty,
              type: BinanceSpotRest.Enums.OrderType._LIMIT_MAKER()
            ] ++
              BinanceSpotRest.Endpoints.Trading.Order.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.value_of_values(:type, [BinanceSpotRest.Enums.OrderType._LIMIT_MAKER()])
        |> Valpa.string(:symbol)
        |> Valpa.value_of_values(:side, BinanceSpotRest.Enums.Side.values())
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
