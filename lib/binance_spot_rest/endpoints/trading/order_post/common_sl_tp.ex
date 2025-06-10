defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.CommonSlTp do
  @moduledoc false

  def fields do
    [:symbol, :side, :quantity, :stopPrice, :trailingDelta]
  end

  def validation(q, remap) do
    q
    |> Valpa.string(remap.(:symbol))
    |> Valpa.value_of_values(remap.(:side), BinanceSpotRest.Enums.Side.values())
    |> Valpa.decimal(remap.(:quantity))
    |> Valpa.map_inclusive_keys([remap.(:stopPrice), remap.(:trailingDelta)])
    |> Valpa.maybe_decimal(remap.(:stopPrice))
    |> Valpa.maybe_integer(remap.(:trailingDelta))
  end
end
