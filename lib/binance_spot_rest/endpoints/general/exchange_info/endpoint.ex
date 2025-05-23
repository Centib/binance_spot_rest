defmodule BinanceSpotRest.Endpoints.General.ExchangeInfo.Endpoint do
  @moduledoc """
  ### Exchange information

  ```
  GET /api/v3/exchangeInfo
  ```

  Current exchange trading rules and symbol information

  **Weight:** 20

  Full docs: [Binance API – exchangeInfo](https://binance-docs.github.io/apidocs/spot/en/#exchange-information)
  """

  def metadata do
    %BinanceSpotRest.Query.EndpointMetadata{
      endpoint: "/api/v3/exchangeInfo",
      method: BinanceSpotRest.Enums.Method._get(),
      security_type: BinanceSpotRest.Enums.SecurityType._NONE()
    }
  end
end
