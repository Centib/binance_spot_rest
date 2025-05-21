defmodule BinanceSpotRest.Enums.WindowSize do
  @moduledoc false

  @minute_range Enum.map(1..59, &"#{&1}m")
  @hour_range Enum.map(1..23, &"#{&1}h")
  @day_range Enum.map(1..7, &"#{&1}d")
  @allowed @minute_range ++ @hour_range ++ @day_range

  use Enuma, @allowed
end
