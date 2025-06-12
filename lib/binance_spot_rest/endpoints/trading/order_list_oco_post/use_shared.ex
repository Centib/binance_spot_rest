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

  @spec fields(module(), module(), keyword(side: atom())) :: keyword()
  def fields(above_shared, below_shared, side: side) do
    af = remap_fields(above_shared.fields(), @above)
    bf = remap_fields(below_shared.fields(), @below)

    Enum.uniq(af ++ bf) |> Keyword.put(:side, side)
  end

  defp remap(field, mapper) do
    Map.get(mapper, field, field)
  end

  @spec validation(struct(), module(), module()) :: {:ok, struct()} | {:error, any()}
  def validation(q, above_shared, below_shared) do
    with {:ok, _} <- above_shared.validation(q, &remap(&1, @above)),
         {:ok, _} <- below_shared.validation(q, &remap(&1, @below)) do
      {:ok, q}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
