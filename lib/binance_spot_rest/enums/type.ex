defmodule BinanceSpotRest.Enums.Type do
  @moduledoc """
  Defines symbol quote types for the Binance Spot market.

  For example this enum corresponds to the `type` parameter in the
  [Binance API – Rolling window price change statistics](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#rolling-window-price-change-statistics).

  And other endpoints with `type` parameter.

  Supported values:

    * `:FULL` – Full symbol information including all trading details.
    * `:MINI` – Minimal symbol information with essential details only.
  """

  use Numa, [:FULL, :MINI]
end
