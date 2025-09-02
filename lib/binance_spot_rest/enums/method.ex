defmodule BinanceSpotRest.Enums.Method do
  @moduledoc """
  Defines HTTP methods supported by the Binance Spot REST API.

    * `:get` — Retrieve data
    * `:post` — Create a resource or send data
    * `:put` — Update an existing resource
    * `:delete` — Remove a resource
  """
  use Numa, [:get, :post, :put, :delete]
end
