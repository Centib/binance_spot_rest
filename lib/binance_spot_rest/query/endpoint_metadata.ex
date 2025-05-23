defmodule BinanceSpotRest.Query.EndpointMetadata do
  @moduledoc """
  EndpointMetadata struct
  """

  @enforce_keys [:endpoint, :method, :security_type]
  defstruct [:endpoint, :method, :security_type]
end
