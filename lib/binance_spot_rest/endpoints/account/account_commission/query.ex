defmodule BinanceSpotRest.Endpoints.Account.AccountCommission.Query do
  @moduledoc """
  ### Query Commission Rates (USER_DATA)

  ```
  GET /api/v3/account/commission
  ```

  Get current account commission rates.

  **Weight:**
  20

  **Parameters:**

  | Name   | Type   | Mandatory | Description |
  | ------ | ------ | --------- | ----------- |
  | symbol | STRING | YES       |             |

  **Data Source:**
  Database

  **Response:**

  ```javascript
  {
    "symbol": "BTCUSDT",
    "standardCommission": {         //Commission rates on trades from the order.
      "maker": "0.00000010",
      "taker": "0.00000020",
      "buyer": "0.00000030",
      "seller": "0.00000040"
    },
    "taxCommission": {              //Tax commission rates for trades from the order.
      "maker": "0.00000112",
      "taker": "0.00000114",
      "buyer": "0.00000118",
      "seller": "0.00000116"
    },
    "discount": {                   //Discount commission when paying in BNB
      "enabledForAccount": true,
      "enabledForSymbol": true,
      "discountAsset": "BNB",
      "discount": "0.75000000"      //Standard commission is reduced by this rate when paying commission in BNB.
    }
  }
  ```
  """

  defstruct [:symbol]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.string(:symbol)

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/account/commission",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._USER_DATA()
        },
        query: q
      }
  end
end
