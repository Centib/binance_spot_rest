defmodule BinanceSpotRest.Endpoints.Trading.OrderPost.Endpoint do
  @moduledoc false

  def moduledoc do
    """
    ### New order (TRADE)

    ```
    POST /api/v3/order
    ```

    Send in a new order.

    **Weight:**
    1


    **Data Source:**
    Matching Engine

    Full docs: [Binance API – order](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#new-order-trade)
    """
  end

  def metadata do
    %BinanceSpotRest.Query.EndpointMetadata{
      endpoint: "/api/v3/order",
      method: BinanceSpotRest.Enums.Method._post(),
      security_type: BinanceSpotRest.Enums.SecurityType._TRADE()
    }
  end
end
