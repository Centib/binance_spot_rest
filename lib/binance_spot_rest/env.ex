defmodule BinanceSpotRest.Env do
  @moduledoc false
  defp app, do: :binance_spot_rest
  def base_url, do: Application.get_env(app(), :base_url)
  def api_key, do: Application.get_env(app(), :api_key)
  def secret_key, do: Application.get_env(app(), :secret_key)
end
