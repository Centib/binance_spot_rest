defmodule BinanceSpotRest.Query.Timestamp do
  @moduledoc false
  def create, do: :os.system_time(:millisecond)
end
