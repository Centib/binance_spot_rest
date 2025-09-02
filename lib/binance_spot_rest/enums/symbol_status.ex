defmodule BinanceSpotRest.Enums.SymbolStatus do
  @moduledoc """
  Defines the trading status of a symbol in the Binance Spot market.

  This enum corresponds to the `status` field in the
  [Binance API – Exchange Information](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#exchange-information).

  Supported values:

    * `:TRADING` – The symbol is active and trading is allowed.
    * `:HALT` – Trading for the symbol is temporarily halted.
    * `:BREAK` – Trading for the symbol is in a break period and not allowed.
  """
  use Numa, [:TRADING, :HALT, :BREAK]
end
