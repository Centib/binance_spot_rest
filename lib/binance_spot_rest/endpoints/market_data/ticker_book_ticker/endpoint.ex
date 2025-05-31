defmodule BinanceSpotRest.Endpoints.MarketData.TickerBookTicker.Endpoint do
  @moduledoc """
  ### Symbol order book ticker

  ```
  GET /api/v3/ticker/bookTicker
  ```

  Best price/qty on the order book for a symbol or symbols.

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
        <td>4</td>
    </tr>
    <tr>
        <td>symbols</td>
        <td>Any</td>
        <td>4</td>
    </tr>
  </tbody>
  </table>

  **Data Source:**
  Memory

  Full docs: [Binance API – ticker/bookTicker](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#symbol-order-book-ticker)
  """

  def metadata do
    %BinanceSpotRest.Query.EndpointMetadata{
      endpoint: "/api/v3/ticker/bookTicker",
      method: BinanceSpotRest.Enums.Method._get(),
      security_type: BinanceSpotRest.Enums.SecurityType._NONE()
    }
  end
end
