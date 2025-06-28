defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtocoPost.UseShared do
  @moduledoc false

  import Loe

  @w %{
    type: :workingType,
    side: :workingSide,
    newClientOrderId: :workingClientOrderId,
    price: :workingPrice,
    quantity: :workingQuantity,
    icebergQty: :workingIcebergQty,
    timeInForce: :workingTimeInForce,
    strategyId: :workingStrategyId,
    strategyType: :workingStrategyType
  }

  @pa %{
    type: :pendingAboveType,
    newClientOrderId: :pendingAboveClientOrderId,
    price: :pendingAbovePrice,
    stopPrice: :pendingAboveStopPrice,
    trailingDelta: :pendingAboveTrailingDelta,
    icebergQty: :pendingAboveIcebergQty,
    timeInForce: :pendingAboveTimeInForce,
    strategyId: :pendingAboveStrategyId,
    strategyType: :pendingAboveStrategyType
  }

  @pb %{
    type: :pendingBelowType,
    newClientOrderId: :pendingBelowClientOrderId,
    price: :pendingBelowPrice,
    stopPrice: :pendingBelowStopPrice,
    trailingDelta: :pendingBelowTrailingDelta,
    icebergQty: :pendingBelowIcebergQty,
    timeInForce: :pendingBelowTimeInForce,
    strategyId: :pendingBelowStrategyId,
    strategyType: :pendingBelowStrategyType
  }

  @pc %{
    side: :pendingSide,
    quantity: :pendingQuantity
  }

  @c %{
    symbol: :symbol,
    newOrderRespType: :newOrderRespType,
    selfTradePreventionMode: :selfTradePreventionMode,
    recvWindow: :recvWindow
  }

  @working Map.merge(@w, @c)
  @pending_above @pa |> Map.merge(@pc) |> Map.merge(@c)
  @pending_below @pb |> Map.merge(@pc) |> Map.merge(@c)

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

  @spec fields(module(), module(), module(), pendingSide: atom()) :: keyword()
  def fields(working_shared, pending_above_shared, pending_below_shared, pendingSide: pendingSide) do
    wf = remap_fields(working_shared.fields(), @working)
    paf = remap_fields(pending_above_shared.fields(), @pending_above)
    pbf = remap_fields(pending_below_shared.fields(), @pending_below)

    Enum.uniq(wf ++ paf ++ pbf) |> Keyword.put(:pendingSide, pendingSide)
  end

  defp remap(field, mapper) do
    Map.get(mapper, field, field)
  end

  @spec validation(struct() | {:ok, struct() | {:error, any()}}, module(), module(), module()) ::
          {:ok, struct()} | {:error, any()}
  def validation(q, working_shared, pending_above_shared, pending_below_shared) do
    q
    ~>> working_shared.validation(&remap(&1, @working))
    ~>> pending_above_shared.validation(&remap(&1, @pending_above))
    ~>> pending_below_shared.validation(&remap(&1, @pending_below))
  end
end
