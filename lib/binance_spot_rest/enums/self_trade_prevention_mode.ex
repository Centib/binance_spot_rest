defmodule BinanceSpotRest.Enums.SelfTradePreventionMode do
  @moduledoc false
  use Numa, [
    :NONE,
    :EXPIRE_MAKER,
    :EXPIRE_TAKER,
    :EXPIRE_BOTH
  ]
end
