defmodule BinanceSpotRest.Enums.OrderType do
  @moduledoc false
  use Enuma, [
    :LIMIT,
    :MARKET,
    :STOP_LOSS,
    :STOP_LOSS_LIMIT,
    :TAKE_PROFIT,
    :TAKE_PROFIT_LIMIT,
    :LIMIT_MAKER
  ]
end
