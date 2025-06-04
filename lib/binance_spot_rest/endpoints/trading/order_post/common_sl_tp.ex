defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.CommonSlTp do
  @moduledoc false

  def fields do
    [:symbol, :side, :quantity, :stopPrice, :trailingDelta]
  end

  def validation(q) do
    q
    |> Valpa.string(:symbol)
    |> Valpa.value_of_values(:side, BinanceSpotRest.Enums.Side.values())
    |> Valpa.decimal(:quantity)
    |> Valpa.map_inclusive_keys([:stopPrice, :trailingDelta])
    |> Valpa.maybe_decimal(:stopPrice)
    |> Valpa.maybe_integer(:trailingDelta)
  end
end
