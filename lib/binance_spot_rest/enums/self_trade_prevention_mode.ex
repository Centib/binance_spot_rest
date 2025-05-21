defmodule BinanceSpotRest.Enums.SelfTradePreventionMode do
  @moduledoc false
  use Enuma, [
    :NONE,
    :EXPIRE_MAKER,
    :EXPIRE_TAKER,
    :EXPIRE_BOTH
  ]
end
