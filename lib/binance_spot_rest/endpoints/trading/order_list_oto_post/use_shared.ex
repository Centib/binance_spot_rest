defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.UseShared do
  @moduledoc false

  @w %{
    type: :workingType,
    side: :workingSide,
    newClientOrderId: :workingClientOrderId,
    quantity: :workingQuantity,
    icebergQty: :workingIcebergQty,
    price: :workingPrice,
    timeInForce: :workingTimeInForce,
    strategyId: :workingStrategyId,
    strategyType: :workingStrategyType
  }

  @p %{
    type: :pendingType,
    side: :pendingSide,
    newClientOrderId: :pendingClientOrderId,
    quantity: :pendingQuantity,
    icebergQty: :pendingIcebergQty,
    price: :pendingPrice,
    stopPrice: :pendingStopPrice,
    trailingDelta: :pendingTrailingDelta,
    timeInForce: :pendingTimeInForce,
    strategyId: :pendingStrategyId,
    strategyType: :pendingStrategyType
  }

  @c %{
    symbol: :symbol,
    newOrderRespType: :newOrderRespType,
    selfTradePreventionMode: :selfTradePreventionMode,
    recvWindow: :recvWindow
  }

  @working Map.merge(@w, @c)
  @pending Map.merge(@p, @c)

  defp remap_fields(fields, mapper) do
    pairs =
      for item <- fields do
        case item do
          {f, v} -> {f, v}
          f -> {f, nil}
        end
      end

    for {f, v} <- pairs,
        Map.has_key?(mapper, f),
        do: {mapper[f], v}
  end

  @spec fields(module(), module()) :: keyword()
  def fields(working_shared, pending_shared) do
    af = remap_fields(working_shared.fields(), @working)
    bf = remap_fields(pending_shared.fields(), @pending)

    # Remove :quoteOrderQty if it was included (e.g., from MARKET-type shared logic).
    # In OTO, :quoteOrderQty is not allowed — only :quantity is valid —
    # so we strip it here just in case it slipped through.
    Enum.uniq(af ++ bf) |> Keyword.delete(:quoteOrderQty)
  end

  defp remap(field, mapper) do
    Map.get(mapper, field, field)
  end

  @spec validation(struct(), module(), module()) :: {:ok, struct()} | {:error, any()}
  def validation(q, working_shared, pending_shared) do
    # OTO always requires :pendingQuantity, regardless of order type.
    # In standard MARKET orders (non-OTO), quantity and quoteOrderQty are mutually exclusive,
    # but quoteOrderQty is forbidden in OTO entirely — so we explicitly validate quantity here.
    # This check is redundant for other order types (quantity is already required),
    # but keeping it here makes the OTO validation logic self-contained and consistent.
    with {:ok, _} <- Valpa.decimal(q, :pendingQuantity),
         {:ok, _} <- working_shared.validation(q, &remap(&1, @working)),
         {:ok, _} <- pending_shared.validation(q, &remap(&1, @pending)) do
      {:ok, q}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
