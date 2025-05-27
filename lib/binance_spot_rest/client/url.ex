defmodule BinanceSpotRest.Client.Url do
  @moduledoc false

  import BinanceSpotRest.Client.Security

  def append_query_string("", endpoint), do: endpoint
  def append_query_string(query_string, endpoint), do: "#{endpoint}?#{query_string}"

  def build(query, endpoint, security_type, _secret_key_fn, _timestamp_fn, _signature_fn)
      when is_struct(query) and map_size(query) == 1 and is_no_signature(security_type) do
    endpoint
  end

  def build(query, endpoint, security_type, _secret_key_fn, _timestamp_fn, _signature_fn)
      when is_struct(query) and is_no_signature(security_type) do
    query
    |> BinanceSpotRest.Client.QueryString.create()
    |> append_query_string(endpoint)
  end

  def build(query, endpoint, security_type, secret_key_fn, timestamp_fn, signature_fn)
      when is_struct(query) and is_signature(security_type) do
    secret_key = secret_key_fn.()
    timestamp = timestamp_fn.()

    query
    |> BinanceSpotRest.Client.QueryString.create()
    |> BinanceSpotRest.Client.QueryString.attach_timestamp(timestamp)
    |> BinanceSpotRest.Client.QueryString.attach_signature(secret_key, signature_fn)
    |> append_query_string(endpoint)
  end
end
