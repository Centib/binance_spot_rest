defmodule BinanceSpotRest.Enums.Interval do
  @moduledoc """
  Defines kline/candlestick intervals for Binance Spot API endpoints.

  This enum is used in the
  [Kline/Candlestick data](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#klinecandlestick-data)
  and
  [UIKlines](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#uiklines) endpoints.

  Supported values:

    * Seconds: `:"1s"`
    * Minutes: `:"1m"`, `:"3m"`, `:"5m"`, `:"15m"`, `:"30m"`
    * Hours: `:"1h"`, `:"2h"`, `:"4h"`, `:"6h"`, `:"8h"`, `:"12h"`
    * Days: `:"1d"`, `:"3d"`
    * Weeks: `:"1w"`
    * Months: `:"1M"`
  """
  use Numa, [
    :"1s",
    :"1m",
    :"3m",
    :"5m",
    :"15m",
    :"30m",
    :"1h",
    :"2h",
    :"4h",
    :"6h",
    :"8h",
    :"12h",
    :"1d",
    :"3d",
    :"1w",
    :"1M"
  ]
end
