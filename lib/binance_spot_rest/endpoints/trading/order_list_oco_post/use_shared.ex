defmodule BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.UseShared do
  @moduledoc false

  @a %{
    type: :aboveType,
    newClientOrderId: :aboveClientOrderId,
    icebergQty: :aboveIcebergQty,
    price: :abovePrice,
    stopPrice: :aboveStopPrice,
    trailingDelta: :aboveTrailingDelta,
    timeInForce: :aboveTimeInForce,
    strategyId: :aboveStrategyId,
    strategyType: :aboveStrategyType
  }

  @b %{
    type: :belowType,
    newClientOrderId: :belowClientOrderId,
    icebergQty: :belowIcebergQty,
    price: :belowPrice,
    stopPrice: :belowStopPrice,
    trailingDelta: :belowTrailingDelta,
    timeInForce: :belowTimeInForce,
    strategyId: :belowStrategyId,
    strategyType: :belowStrategyType
  }

  @c %{
    symbol: :symbol,
    side: :side,
    quantity: :quantity,
    newOrderRespType: :newOrderRespType,
    selfTradePreventionMode: :selfTradePreventionMode,
    recvWindow: :recvWindow
  }

  @above Map.merge(@a, @c)
  @below Map.merge(@b, @c)

  @above_reverse Map.new(@above, fn {k, v} -> {v, k} end)
  @below_reverse Map.new(@below, fn {k, v} -> {v, k} end)

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

  @spec fields(module(), module()) :: list(atom())
  def fields(above_shared, below_shared) do
    af = remap_fields(above_shared.fields(), @above)
    bf = remap_fields(below_shared.fields(), @below)

    Enum.uniq(af ++ bf)
  end

  defp remap_back(q, mapper) do
    map = Map.from_struct(q)

    for {f, v} <- map,
        Map.has_key?(mapper, f),
        into: %{},
        do: {mapper[f], v}
  end

  @spec validation(struct(), module(), module()) :: {:ok, struct()} | {:error, any()}
  def validation(q, above_shared, below_shared) do
    above_input = remap_back(q, @above_reverse)
    below_input = remap_back(q, @below_reverse)

    with {:ok, _} <- above_shared.validation(above_input),
         {:ok, _} <- below_shared.validation(below_input) do
      {:ok, q}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
