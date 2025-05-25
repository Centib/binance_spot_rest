defmodule BinanceSpotRest.Client.Url do
  @moduledoc false

  import BinanceSpotRest.Client.Security

  def append_query_string("", endpoint), do: endpoint
  def append_query_string(query_string, endpoint), do: "#{endpoint}?#{query_string}"

  def build(q, endpoint, st, _secret_key, _timestamp)
      when is_struct(q) and map_size(q) == 1 and is_no_signature(st) do
    endpoint
  end

  def build(q, endpoint, st, _secret_key, _timestamp) when is_struct(q) and is_no_signature(st) do
    q
    |> BinanceSpotRest.Client.QueryString.create()
    |> append_query_string(endpoint)
  end

  def build(q, endpoint, st, secret_key, timestamp) when is_struct(q) and is_signature(st) do
    secret_key = if secret_key == nil, do: BinanceSpotRest.Env.secret_key()
    timestamp = if timestamp == nil, do: BinanceSpotRest.Client.Timestamp.create()

    q
    |> BinanceSpotRest.Client.QueryString.create()
    |> BinanceSpotRest.Client.QueryString.attach_timestamp(timestamp)
    |> BinanceSpotRest.Client.QueryString.attach_signature(secret_key)
    |> append_query_string(endpoint)
  end
end
