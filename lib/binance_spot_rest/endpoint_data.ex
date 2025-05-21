defmodule BinanceSpotRest.EndpointData do
  @moduledoc """
  Endpoint data
  """
  @enforce_keys [:endpoint, :method, :security_type]
  defstruct [:endpoint, :method, :security_type]
end
