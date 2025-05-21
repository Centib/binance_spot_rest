defmodule BinanceSpotRest.Query.Signature do
  @moduledoc false
  def create(query_string, secret_key) do
    :hmac
    |> :crypto.mac(:sha256, secret_key, query_string)
    |> Base.encode16()
  end
end
