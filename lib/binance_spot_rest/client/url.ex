defmodule BinanceSpotRest.Client.Url do
  @moduledoc false

  def create("", endpoint), do: endpoint
  def create(query_string, endpoint), do: "#{endpoint}?#{query_string}"
end
