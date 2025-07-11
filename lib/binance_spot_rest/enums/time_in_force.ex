defmodule BinanceSpotRest.Enums.TimeInForce do
  @moduledoc """
  ### Time in force (timeInForce)

  This sets how long an order will be active before expiration.

  | Status | Description                                                                                               |
  | ------ | --------------------------------------------------------------------------------------------------------- |
  | `GTC`  | Good Til Canceled. An order will be on the book unless the order is canceled.                             |
  | `IOC`  | Immediate Or Cancel. An order will try to fill the order as much as it can before the order expires.      |
  | `FOK`  | Fill or Kill. An order will expire if the full order cannot be filled upon execution.                     |
  """

  use Numa, [:GTC, :IOC, :FOK]
end
