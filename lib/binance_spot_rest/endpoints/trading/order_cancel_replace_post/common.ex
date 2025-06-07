defmodule BinanceSpotRest.Endpoints.Trading.OrderCancelReplacePost.Common do
  @moduledoc false

  def fields do
    [
      :cancelReplaceMode,
      :cancelNewClientOrderId,
      :cancelOrigClientOrderId,
      :cancelOrderId,
      :cancelRestrictions,
      :orderRateLimitExceededMode
    ]
  end

  def validation(q) do
    q
    |> Valpa.value_of_values(
      :cancelReplaceMode,
      BinanceSpotRest.Enums.CancelReplaceMode.values()
    )
    |> Valpa.maybe_string(:cancelNewClientOrderId)
    |> Valpa.map_inclusive_keys([:cancelOrderId, :cancelOrigClientOrderId])
    |> Valpa.maybe_integer(:cancelOrderId)
    |> Valpa.maybe_string(:cancelOrigClientOrderId)
    |> Valpa.maybe_value_of_values(
      :cancelRestrictions,
      BinanceSpotRest.Enums.CancelRestrictions.values()
    )
    |> Valpa.maybe_value_of_values(
      :orderRateLimitExceededMode,
      BinanceSpotRest.Enums.OrderRateLimitExceededMode.values()
    )
  end
end
