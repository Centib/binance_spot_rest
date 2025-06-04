defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.LimitMakerQuery do
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
              BinanceSpotRest.Endpoints.Trading.OrderPost.Common.fields()

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
        |> BinanceSpotRest.Endpoints.Trading.OrderPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint.metadata(),
        query: q
      }
  end
end
