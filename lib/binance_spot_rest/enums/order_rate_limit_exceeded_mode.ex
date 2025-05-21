defmodule BinanceSpotRest.Enums.OrderRateLimitExceededMode do
  @moduledoc false
  use Enuma, [
    :DO_NOTHING,
    :CANCEL_ONLY
  ]
end
