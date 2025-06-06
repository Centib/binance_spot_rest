defmodule BinanceSpotRest.Endpoints.Trading.OrderTestPost.Common do
  @moduledoc false

  def fields do
    [:computeCommissionRates]
  end

  def validation(q) do
    q
    |> Valpa.maybe_boolean(:computeCommissionRates)
  end
end
