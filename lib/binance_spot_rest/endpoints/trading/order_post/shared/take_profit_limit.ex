defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.TakeProfitLimit do
  @moduledoc false

  def fields do
    [type: BinanceSpotRest.Enums.OrderType._TAKE_PROFIT_LIMIT()] ++
      BinanceSpotRest.Endpoints.Trading.OrderPost.CommonSllTpl.fields() ++
      BinanceSpotRest.Endpoints.Trading.OrderPost.Common.fields()
  end

  def validation(q, remap \\ &Function.identity/1) do
    q
    |> Valpa.value_of_values(remap.(:type), [BinanceSpotRest.Enums.OrderType._TAKE_PROFIT_LIMIT()])
    |> BinanceSpotRest.Endpoints.Trading.OrderPost.CommonSllTpl.validation()
    |> BinanceSpotRest.Endpoints.Trading.OrderPost.Common.validation()
  end
end
