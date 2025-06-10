defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.Market do
  @moduledoc false

  def fields do
    [
      :symbol,
      :side,
      :quantity,
      :quoteOrderQty,
      type: BinanceSpotRest.Enums.OrderType._MARKET()
    ] ++ BinanceSpotRest.Endpoints.Trading.OrderPost.Common.fields()
  end

  def validation(q, remap \\ &Function.identity/1) do
    q
    |> Valpa.value_of_values(remap.(:type), [BinanceSpotRest.Enums.OrderType._MARKET()])
    |> Valpa.string(remap.(:symbol))
    |> Valpa.value_of_values(remap.(:side), BinanceSpotRest.Enums.Side.values())
    |> Valpa.map_exclusive_keys([remap.(:quantity), remap.(:quoteOrderQty)])
    |> Valpa.maybe_decimal(remap.(:quantity))
    |> Valpa.maybe_decimal(remap.(:quoteOrderQty))
    |> BinanceSpotRest.Endpoints.Trading.OrderPost.Common.validation(remap)
  end
end
