defmodule BinanceSpotRest.RequestData do
  @moduledoc """
  Request data
  """
  @enforce_keys [:endpoint_data, :query]
  defstruct [:endpoint_data, :query]
end
