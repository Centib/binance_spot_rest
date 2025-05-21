defmodule BinanceSpotRest.Client.Request do
  @moduledoc """
  Request struct
  """
  @enforce_keys [:method, :headers, :base_url, :url]
  defstruct [:method, :headers, :base_url, :url]
end
