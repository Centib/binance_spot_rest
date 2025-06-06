defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Limit do
  @moduledoc false

  def fields do
    [
      :symbol,
      :side,
      :timeInForce,
      :quantity,
      :price,
      :icebergQty,
      type: BinanceSpotRest.Enums.OrderType._LIMIT()
    ] ++ BinanceSpotRest.Endpoints.Trading.OrderPost.Common.fields()
  end

  def validation(q) do
    q
    |> Valpa.value_of_values(:type, [BinanceSpotRest.Enums.OrderType._LIMIT()])
    |> Valpa.string(:symbol)
    |> Valpa.value_of_values(:side, BinanceSpotRest.Enums.Side.values())
    |> Valpa.value_of_values(:timeInForce, BinanceSpotRest.Enums.TimeInForce.values())
    |> Valpa.decimal(:quantity)
    |> Valpa.decimal(:price)
    |> Valpa.Custom.validator(BinanceSpotRest.Validators.IcebergQty)
    |> BinanceSpotRest.Endpoints.Trading.OrderPost.Common.validation()
  end
end
