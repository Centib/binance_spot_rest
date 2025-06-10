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

  def validation(q, remap \\ &Function.identity/1) do
    q
    |> Valpa.value_of_values(remap.(:type), [BinanceSpotRest.Enums.OrderType._LIMIT_MAKER()])
    |> Valpa.string(remap.(:symbol))
    |> Valpa.value_of_values(remap.(:side), BinanceSpotRest.Enums.Side.values())
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
