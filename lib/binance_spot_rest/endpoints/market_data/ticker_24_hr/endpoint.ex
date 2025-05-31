defmodule BinanceSpotRest.Endpoints.MarketData.Ticker24Hr.Endpoint do
    @moduledoc """
  ### 24hr ticker price change statistics

  ```
  GET /api/v3/ticker/24hr
  ```

  24 hour rolling window price change statistics. **Careful** when accessing this with no symbol.

  **Weight:**

  <table>
  <thead>
    <tr>
        <th>Parameter</th>
        <th>Symbols Provided</th>
        <th>Weight</th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <td rowspan="2">symbol</td>
        <td>1</td>
        <td>2</td>
    </tr>
    <tr>
        <td>symbol parameter is omitted</td>
        <td>80</td>
    </tr>
    <tr>
        <td rowspan="4">symbols</td>
        <td>1-20</td>
        <td>2</td>
    </tr>
    <tr>
        <td>21-100</td>
        <td>40</td>
    </tr>
    <tr>
        <td>101 or more</td>
        <td>80</td>
    </tr>
    <tr>
        <td>symbols parameter is omitted</td>
        <td>80</td>
    </tr>
  </tbody>
  </table>

  **Data Source:**
  Memory

  Full docs: [Binance API – ticker/24hr](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#24hr-ticker-price-change-statistics)
  """

  def metadata do
    %BinanceSpotRest.Query.EndpointMetadata{
      endpoint: "/api/v3/ticker/24hr",
      method: BinanceSpotRest.Enums.Method._get(),
      security_type: BinanceSpotRest.Enums.SecurityType._NONE()
    }
  end
end
