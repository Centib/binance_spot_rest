defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.Common do
  @moduledoc false

  def fields do
    [:listClientOrderId]
  end

  def validation(q) do
    q
    |> Valpa.maybe_string(:listClientOrderId)
  end
end
