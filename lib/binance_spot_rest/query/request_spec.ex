defmodule BinanceSpotRest.Query.RequestSpec do
  @moduledoc """
  RequestSpec structure
  """

  @enforce_keys [:endpoint, :method, :security_type, :query]
  defstruct [:endpoint, :method, :security_type, :query]
end
