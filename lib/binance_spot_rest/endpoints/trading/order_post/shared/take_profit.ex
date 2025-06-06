defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfit do
  @moduledoc false

  def fields do
    [type: BinanceSpotRest.Enums.OrderType._TAKE_PROFIT()] ++
      BinanceSpotRest.Endpoints.Trading.OrderPost.CommonSlTp.fields() ++
      BinanceSpotRest.Endpoints.Trading.OrderPost.Common.fields()
  end

  def validation(q) do
    q
    |> Valpa.value_of_values(:type, [BinanceSpotRest.Enums.OrderType._TAKE_PROFIT()])
    |> BinanceSpotRest.Endpoints.Trading.OrderPost.CommonSlTp.validation()
    |> BinanceSpotRest.Endpoints.Trading.OrderPost.Common.validation()
  end
end
