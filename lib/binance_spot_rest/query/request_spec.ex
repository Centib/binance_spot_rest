defmodule BinanceSpotRest.Query.RequestSpec do
  @moduledoc """
  RequestSpec struct
  """

  @enforce_keys [:metadata, :query]
  defstruct [:metadata, :query]
end
