defmodule BinanceSpotRest.Endpoints.Trading.OpenOrdersDelete.Query do
  @moduledoc """
  ### Cancel All Open Orders on a Symbol (TRADE)
  ```
  DELETE /api/v3/openOrders
  ```
  Cancels all active orders on a symbol.
  This includes orders that are part of an order list.

  **Weight:**
  1

  **Parameters:**

  | Name       | Type   | Mandatory | Description                              |
  | ---------- | ------ | --------- | ---------------------------------------- |
  | symbol     | STRING | YES       |                                          |
  | recvWindow | LONG   | NO        | The value cannot be greater than `60000` |
  | timestamp  | LONG   | YES       |                                          |


  **Data Source:**
  Matching Engine

  Full docs: [Binance API – openOrders DELETE](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#cancel-all-open-orders-on-a-symbol-trade)
  """

  defstruct [:symbol, :recvWindow]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.maybe_integer_in_range(:recvWindow, %{min: 0, max: 60_000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/openOrders",
          method: BinanceSpotRest.Enums.Method._delete(),
          security_type: BinanceSpotRest.Enums.SecurityType._TRADE()
        },
        query: q
      }
  end
end
