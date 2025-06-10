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

  def validation(q, remap \\ &Function.identity/1) do
    q
    |> Valpa.value_of_values(remap.(:type), [BinanceSpotRest.Enums.OrderType._LIMIT()])
    |> Valpa.string(remap.(:symbol))
    |> Valpa.value_of_values(remap.(:side), BinanceSpotRest.Enums.Side.values())
    |> Valpa.value_of_values(remap.(:timeInForce), BinanceSpotRest.Enums.TimeInForce.values())
    |> Valpa.decimal(remap.(:quantity))
    |> Valpa.decimal(remap.(:price))
    |> Valpa.Custom.validate(
      &BinanceSpotRest.Validators.IcebergQty.validate(
        &1,
        remap.(:icebergQty),
        remap.(:timeInForce),
        remap.(:quantity)
      )
    )
    |> BinanceSpotRest.Endpoints.Trading.OrderPost.Common.validation(remap)
  end
end
