defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.CommonSllTpl do
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

  def validation(q, remap \\ &Function.identity/1) do
    q
    |> Valpa.string(remap.(:symbol))
    |> Valpa.value_of_values(remap.(:side), BinanceSpotRest.Enums.Side.values())
    |> Valpa.value_of_values(remap.(:timeInForce), BinanceSpotRest.Enums.TimeInForce.values())
    |> Valpa.decimal(remap.(:quantity))
    |> Valpa.decimal(remap.(:price))
    |> Valpa.map_inclusive_keys([remap.(:stopPrice), remap.(:trailingDelta)])
    |> Valpa.maybe_decimal(remap.(:stopPrice))
    |> Valpa.maybe_integer(remap.(:trailingDelta))
    |> Valpa.Custom.validate(
      &BinanceSpotRest.Validators.IcebergQty.validate(
        &1,
        remap.(:icebergQty),
        remap.(:timeInForce),
        remap.(:quantity)
      )
    )
  end
end
