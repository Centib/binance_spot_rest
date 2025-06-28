defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.UseShared do
  @moduledoc false

  import Loe

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
    strategyType: :pendingStrategyType,
    quoteOrderQty: :pendingQuoteOrderQty
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
    wf = remap_fields(working_shared.fields(), @working)
    pf = remap_fields(pending_shared.fields(), @pending)

    Enum.uniq(wf ++ pf)
  end

  defp remap(field, mapper) do
    Map.get(mapper, field, field)
  end

  @spec validation(struct() | {:ok, struct() | {:error, any()}}, module(), module()) ::
          {:ok, struct()} | {:error, any()}
  def validation(q, working_shared, pending_shared) do
    q
    ~>> working_shared.validation(&remap(&1, @working))
    ~>> pending_shared.validation(&remap(&1, @pending))
  end
end
