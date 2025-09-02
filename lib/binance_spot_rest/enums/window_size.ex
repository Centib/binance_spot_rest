defmodule BinanceSpotRest.Enums.WindowSize do
  @moduledoc """
  Defines allowed window sizes for Binance Spot API endpoints that require a time interval.

  This enum is commonly used for endpoints such as
  [Rolling window price change statistics](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#rolling-window-price-change-statistics).

  And other endpoints with windowSize parameter.

  Supported values:

    * Minute intervals: `:1m` to `:59m`
    * Hour intervals: `:1h` to `:23h`
    * Day intervals: `:1d` to `:7d`
  """

  @minute_range Enum.map(1..59, &"#{&1}m")
  @hour_range Enum.map(1..23, &"#{&1}h")
  @day_range Enum.map(1..7, &"#{&1}d")
  @allowed @minute_range ++ @hour_range ++ @day_range

  use Numa, @allowed
end
