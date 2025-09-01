defmodule BinanceSpotRest.Endpoints.Account.OrderAmendments.Query do
  @moduledoc """
  Order Amendments

  ### Query Order Amendments (USER_DATA)

  ```
  GET /api/v3/order/amendments
  ```

  Queries all amendments of a single order.

  **Weight**:
  4

  **Parameters:**

  | Name            | Type   | Mandatory | Description                               |
  | :-------------- | :----- | :-------- | :---------------------------------------- |
  | symbol          | STRING | YES       |                                           |
  | orderId         | LONG   | YES       |                                           |
  | fromExecutionId | LONG   | NO        |                                           |
  | limit           | LONG   | NO        | Default:500; Maximum: 1000                |
  | recvWindow      | LONG   | NO        | The value cannot be greater than `60000`. |
  | timestamp       | LONG   | YES       |                                           |

  **Data Source:**

  Database

  **Response:**

  ```json
  [
    {
        "symbol": "BTCUSDT",
        "orderId": 9,
        "executionId": 22,
        "origClientOrderId": "W0fJ9fiLKHOJutovPK3oJp",
        "newClientOrderId": "UQ1Np3bmQ71jJzsSDW9Vpi",
        "origQty": "5.00000000",
        "newQty": "4.00000000",
        "time": 1741669661670
    },
    {
        "symbol": "BTCUDST",
        "orderId": 9,
        "executionId": 25,
        "origClientOrderId": "UQ1Np3bmQ71jJzsSDW9Vpi",
        "newClientOrderId": "5uS0r35ohuQyDlCzZuYXq2",
        "origQty": "4.00000000",
        "newQty": "3.00000000",
        "time": 1741672924895
    }
  ]
  ```
  """

  defstruct [:symbol, :orderId, :fromExecutionId, :limit, :recvWindow]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)
        |> Valpa.integer(:orderId)
        |> Valpa.maybe_integer(:fromExecutionId)
        |> Valpa.maybe_integer_in_range(:limit, %{min: 0, max: 1000})
        |> Valpa.maybe_integer_in_range(:recvWindow, %{min: 0, max: 60_000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/order/amendments",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._USER_DATA()
        },
        query: q
      }
  end
end
