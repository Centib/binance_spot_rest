defmodule BinanceSpotRest.Client.Headers do
  @moduledoc false
  import BinanceSpotRest.Client.Security

  def build(st) when is_no_api_key(st), do: []
  def build(st) when is_api_key(st), do: [{"X-MBX-APIKEY", BinanceSpotRest.Env.api_key()}]
end
