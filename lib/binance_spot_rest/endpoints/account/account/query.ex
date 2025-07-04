defmodule BinanceSpotRest.Endpoints.Account.Account.Query do
  @moduledoc """
  ### Account information (USER_DATA)

  ```
  GET /api/v3/account
  ```

  Get current account information.

  **Weight:**
  20

  **Parameters:**

  | Name             | Type    | Mandatory | Description                                                                                    |
  | ---------------- | ------- | --------- | ---------------------------------------------------------------------------------------------- |
  | omitZeroBalances | BOOLEAN | NO        | When set to `true`, emits only the non-zero balances of an account. <br>Default value: `false` |
  | recvWindow       | LONG    | NO        | The value cannot be greater than `60000`                                                       |
  | timestamp        | LONG    | YES       |                                                                                                |

  **Data Source:**
  Memory => Database

  **Response:**

  ```javascript
  {
    "makerCommission": 15,
    "takerCommission": 15,
    "buyerCommission": 0,
    "sellerCommission": 0,
    "commissionRates": {
      "maker": "0.00150000",
      "taker": "0.00150000",
      "buyer": "0.00000000",
      "seller": "0.00000000"
    },
    "canTrade": true,
    "canWithdraw": true,
    "canDeposit": true,
    "brokered": false,
    "requireSelfTradePrevention": false,
    "preventSor": false,
    "updateTime": 123456789,
    "accountType": "SPOT",
    "balances": [
      {
        "asset": "BTC",
        "free": "4723846.89208129",
        "locked": "0.00000000"
      },
      {
        "asset": "LTC",
        "free": "4763368.68006011",
        "locked": "0.00000000"
      }
    ],
    "permissions": [
      "SPOT"
    ],
    "uid": 354937868
  }
  ```
  """

  defstruct [:omitZeroBalances, :recvWindow]

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> Valpa.maybe_boolean(:omitZeroBalances)
        |> Valpa.maybe_integer_in_range(:recvWindow, %{min: 0, max: 60_000})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: %BinanceSpotRest.Query.EndpointMetadata{
          endpoint: "/api/v3/account",
          method: BinanceSpotRest.Enums.Method._get(),
          security_type: BinanceSpotRest.Enums.SecurityType._USER_DATA()
        },
        query: q
      }
  end
end
