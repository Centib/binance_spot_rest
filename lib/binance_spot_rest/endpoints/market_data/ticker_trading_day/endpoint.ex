defmodule BinanceSpotRest.Endpoints.MarketData.TickerTradingDay.Endpoint do
  @moduledoc false

  def moduledoc do
    """
    ### Trading Day Ticker

    ```
    GET /api/v3/ticker/tradingDay
    ```

    Price change statistics for a trading day.

    **Weight:**

    4 for each requested <tt>symbol</tt>. <br/><br/> The weight for this request will cap at 200 once the number of `symbols` in the request is more than 50.

    **Notes:**

    - Supported values for `timeZone`:
    - Hours and minutes (e.g. `-1:00`, `05:45`)
    - Only hours (e.g. `0`, `8`, `4`)

    **Data Source:**
    Database

    Full docs: [Binance API – ticker/tradingDay](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#trading-day-ticker)
    """
  end

  def metadata do
    %BinanceSpotRest.Query.EndpointMetadata{
      endpoint: "/api/v3/ticker/tradingDay",
      method: BinanceSpotRest.Enums.Method._get(),
      security_type: BinanceSpotRest.Enums.SecurityType._NONE()
    }
  end
end
