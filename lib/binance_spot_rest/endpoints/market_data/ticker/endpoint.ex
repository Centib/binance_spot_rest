defmodule BinanceSpotRest.Endpoints.MarketData.Ticker.Endpoint do
  @moduledoc """
  ### Rolling window price change statistics

  ```
  GET /api/v3/ticker
  ```

  **Note:** This endpoint is different from the `GET /api/v3/ticker/24hr` endpoint.

  The window used to compute statistics will be no more than 59999ms from the requested `windowSize`.

  `openTime` for `/api/v3/ticker` always starts on a minute, while the `closeTime` is the current time of the request.
  As such, the effective window will be up to 59999ms wider than `windowSize`.

  E.g. If the `closeTime` is 1641287867099 (January 04, 2022 09:17:47:099 UTC) , and the `windowSize` is `1d`. the `openTime` will be: 1641201420000 (January 3, 2022, 09:17:00)

  **Weight:**

  4 for each requested <tt>symbol</tt> regardless of <tt>windowSize</tt>. <br/><br/> The weight for this request will cap at 200 once the number of `symbols` in the request is more than 50.

  **Data Source:**
  Database

  Full docs: [Binance API – ticker](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#rolling-window-price-change-statistics)
  """

  def metadata do
    %BinanceSpotRest.Query.EndpointMetadata{
      endpoint: "/api/v3/ticker",
      method: BinanceSpotRest.Enums.Method._get(),
      security_type: BinanceSpotRest.Enums.SecurityType._NONE()
    }
  end
end
