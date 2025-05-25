defmodule BinanceSpotRest.Endpoints.General.ExchangeInfo.Endpoint do
  @moduledoc """
  ### Exchange information

  ```
  GET /api/v3/exchangeInfo
  ```

  Current exchange trading rules and symbol information

  **Weight:** 20

  **Data Source:** Memory

  Full docs: [Binance API – exchangeInfo](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#exchange-information)
  """

  def metadata do
    %BinanceSpotRest.Query.EndpointMetadata{
      endpoint: "/api/v3/exchangeInfo",
      method: BinanceSpotRest.Enums.Method._get(),
      security_type: BinanceSpotRest.Enums.SecurityType._NONE()
    }
  end
end
