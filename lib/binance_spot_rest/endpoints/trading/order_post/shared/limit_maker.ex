defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker do
  @moduledoc false

  def fields do
    [
      :symbol,
      :side,
      :quantity,
      :price,
      :icebergQty,
      type: BinanceSpotRest.Enums.OrderType._LIMIT_MAKER()
    ] ++
      BinanceSpotRest.Endpoints.Trading.OrderPost.Common.fields()
  end

  def validation(q) do
    q
    |> Valpa.value_of_values(:type, [BinanceSpotRest.Enums.OrderType._LIMIT_MAKER()])
    |> Valpa.string(:symbol)
    |> Valpa.value_of_values(:side, BinanceSpotRest.Enums.Side.values())
    |> Valpa.decimal(:quantity)
    |> Valpa.decimal(:price)
    |> Valpa.Custom.validator(BinanceSpotRest.Validators.IcebergQty)
    |> BinanceSpotRest.Endpoints.Trading.OrderPost.Common.validation()
  end
end
