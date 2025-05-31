defmodule BinanceSpotRest.ValidatorsTest do
  @moduledoc false

  use ExUnit.Case, async: true

  doctest BinanceSpotRest.Validators.TimeZone
  doctest BinanceSpotRest.Validators.WindowSize
  # doctest BinanceSpotRest.Validators.IcebergQty
  # doctest BinanceSpotRest.Validators.StartTimeEndTime
  # doctest BinanceSpotRest.Validators.OcoPricesRelation
end
