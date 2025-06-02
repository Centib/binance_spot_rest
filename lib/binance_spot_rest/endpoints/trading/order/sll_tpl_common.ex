defmodule BinanceSpotRest.Endpoints.Trading.Order.SllTplCommon do
  @moduledoc false

  def fields do
    [
      :symbol,
      :side,
      :timeInForce,
      :quantity,
      :price,
      :stopPrice,
      :trailingDelta,
      :icebergQty
    ]
  end

  def validation(q) do
    q
    |> Valpa.string(:symbol)
    |> Valpa.value_of_values(:side, BinanceSpotRest.Enums.Side.values())
    |> Valpa.value_of_values(:timeInForce, BinanceSpotRest.Enums.TimeInForce.values())
    |> Valpa.decimal(:quantity)
    |> Valpa.decimal(:price)
    |> Valpa.map_inclusive_keys([:stopPrice, :trailingDelta])
    |> Valpa.maybe_decimal(:stopPrice)
    |> Valpa.maybe_integer(:trailingDelta)
    |> Valpa.Custom.validator(BinanceSpotRest.Validators.IcebergQty)
  end
end
