defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.Endpoint do
  @moduledoc """
  #### New Order list - OTO (TRADE)

  ```
  POST /api/v3/orderList/oto
  ```

  Place an OTO.

  - An OTO (One-Triggers-the-Other) is an order list comprised of 2 orders.
  - The first order is called the **working order** and must be `LIMIT` or `LIMIT_MAKER`. Initially, only the working order goes on the order book.
  - The second order is called the **pending order**. It can be any order type except for `MARKET` orders using parameter `quoteOrderQty`. The pending order is only placed on the order book when the working order gets **fully filled**.
  - If either the working order or the pending order is cancelled individually, the other order in the order list will also be canceled or expired.
  - When the order list is placed, if the working order gets **immediately fully filled**, the placement response will show the working order as `FILLED` but the pending order will still appear as `PENDING_NEW`. You need to query the status of the pending order again to see its updated status.
  - OTOs add **2 orders** to the `EXCHANGE_MAX_NUM_ORDERS` filter and `MAX_NUM_ORDERS` filter.

  **Weight:** 1

  **Unfilled Order Count:**
  2

  **Parameters:**

  | Name                    | Type    | Mandatory | Description                                                                                                                                                                                                                                                                                                        |
  | ----------------------- | ------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
  | symbol                  | STRING  | YES       |
  | listClientOrderId       | STRING  | NO        | Arbitrary unique ID among open order lists. Automatically generated if not sent. <br>A new order list with the same listClientOrderId is accepted only when the previous one is filled or completely expired. <br> `listClientOrderId` is distinct from the `workingClientOrderId` and the `pendingClientOrderId`. |
  | newOrderRespType        | ENUM    | NO        | Format of the JSON response. Supported values: [Order Response Type]                                                                                                                                                                                                                 |
  | selfTradePreventionMode | ENUM    | NO        | The allowed values are dependent on what is configured on the symbol. Supported values: [STP Modes]                                                                                                                                                                                           |
  | workingType             | ENUM    | YES       | Supported values: `LIMIT`,`LIMIT_MAKER`                                                                                                                                                                                                                                                                            |
  | workingSide             | ENUM    | YES       | Supported values: [Order Side](./enums.md#side)                                                                                                                                                                                                                                                                    |
  | workingClientOrderId    | STRING  | NO        | Arbitrary unique ID among open orders for the working order.<br> Automatically generated if not sent.                                                                                                                                                                                                              |
  | workingPrice            | DECIMAL | YES       |
  | workingQuantity         | DECIMAL | YES       | Sets the quantity for the working order.                                                                                                                                                                                                                                                                           |
  | workingIcebergQty       | DECIMAL | NO        | This can only be used if `workingTimeInForce` is `GTC`, or if `workingType` is `LIMIT_MAKER`.                                                                                                                                                                                                                      |
  | workingTimeInForce      | ENUM    | NO        | Supported values: [Time In Force]                                                                                                                                                                                                                                                          |
  | workingStrategyId       | LONG    | NO        | Arbitrary numeric value identifying the working order within an order strategy.                                                                                                                                                                                                                                    |
  | workingStrategyType     | INT     | NO        | Arbitrary numeric value identifying the working order strategy. <br> Values smaller than 1000000 are reserved and cannot be used.                                                                                                                                                                                  |
  | pendingType             | ENUM    | YES       | Supported values: [Order Types](#order-type)<br> Note that `MARKET` orders using `quoteOrderQty` are not supported.                                                                                                                                                                                                |
  | pendingSide             | ENUM    | YES       | Supported values: [Order Side](./enums.md#side)                                                                                                                                                                                                                                                                    |
  | pendingClientOrderId    | STRING  | NO        | Arbitrary unique ID among open orders for the pending order.<br> Automatically generated if not sent.                                                                                                                                                                                                              |
  | pendingPrice            | DECIMAL | NO        |
  | pendingStopPrice        | DECIMAL | NO        |
  | pendingTrailingDelta    | DECIMAL | NO        |
  | pendingQuantity         | DECIMAL | YES       | Sets the quantity for the pending order.                                                                                                                                                                                                                                                                           |
  | pendingIcebergQty       | DECIMAL | NO        | This can only be used if `pendingTimeInForce` is `GTC` or if `pendingType` is `LIMIT_MAKER`.                                                                                                                                                                                                                       |
  | pendingTimeInForce      | ENUM    | NO        | Supported values: [Time In Force]                                                                                                                                                                                                                                                          |
  | pendingStrategyId       | LONG    | NO        | Arbitrary numeric value identifying the pending order within an order strategy.                                                                                                                                                                                                                                    |
  | pendingStrategyType     | INT     | NO        | Arbitrary numeric value identifying the pending order strategy. <br> Values smaller than 1000000 are reserved and cannot be used.                                                                                                                                                                                  |
  | recvWindow              | LONG    | NO        | The value cannot be greater than `60000`.                                                                                                                                                                                                                                                                          |
  | timestamp               | LONG    | YES       |

  **Mandatory parameters based on `pendingType` or `workingType`**

  Depending on the `pendingType` or `workingType`, some optional parameters will become mandatory.

  | Type                                                     | Additional mandatory parameters                                                        | Additional information |
  | -------------------------------------------------------- | -------------------------------------------------------------------------------------- | ---------------------- |
  | `workingType` = `LIMIT`                                  | `workingTimeInForce`                                                                   |                        |
  | `pendingType` = `LIMIT`                                  | `pendingPrice`, `pendingTimeInForce`                                                   |                        |
  | `pendingType` = `STOP_LOSS` or `TAKE_PROFIT`             | `pendingStopPrice` and/or `pendingTrailingDelta`                                       |                        |
  | `pendingType` = `STOP_LOSS_LIMIT` or `TAKE_PROFIT_LIMIT` | `pendingPrice`, `pendingStopPrice` and/or `pendingTrailingDelta`, `pendingTimeInForce` |                        |

  **Data Source:**

  Matching Engine

  Full docs: [Binance API – orderList/oto POST](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#new-order-list---oto-trade)
  """

  def metadata do
    %BinanceSpotRest.Query.EndpointMetadata{
      endpoint: "/api/v3/orderList/oto",
      method: BinanceSpotRest.Enums.Method._post(),
      security_type: BinanceSpotRest.Enums.SecurityType._TRADE()
    }
  end
end
