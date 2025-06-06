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

  def validation(q) do
    q
    |> Valpa.value_of_values(:type, [BinanceSpotRest.Enums.OrderType._MARKET()])
    |> Valpa.string(:symbol)
    |> Valpa.value_of_values(:side, BinanceSpotRest.Enums.Side.values())
    |> Valpa.map_exclusive_keys([:quantity, :quoteOrderQty])
    |> Valpa.maybe_decimal(:quantity)
    |> Valpa.maybe_decimal(:quoteOrderQty)
    |> BinanceSpotRest.Endpoints.Trading.OrderPost.Common.validation()
  end
end
