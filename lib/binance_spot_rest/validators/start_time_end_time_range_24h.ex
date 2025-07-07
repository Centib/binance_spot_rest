defmodule BinanceSpotRest.Validators.StartTimeEndTimeRange24h do
  @moduledoc """
  Validate that `endTime` is not before `startTime` and that the interval doesn't exceed 24 hours.

  The time interval (after converting seconds to milliseconds when needed) cannot exceed 24 hours (86,400,000 milliseconds).

  ## Examples

      iex> BinanceSpotRest.Validators.StartTimeEndTimeRange24h.validate(%{startTime: 1_700_000_000_000, endTime: 1_700_000_500_000})
      :ok

      iex> BinanceSpotRest.Validators.StartTimeEndTimeRange24h.validate(%{startTime: 1_700_000_000, endTime: 1_700_000_500})
      :ok

      iex> {:error, _} = BinanceSpotRest.Validators.StartTimeEndTimeRange24h.validate(%{startTime: 1_700_000_500_000, endTime: 1_700_000_000_000})

      iex> {:error, _} = BinanceSpotRest.Validators.StartTimeEndTimeRange24h.validate(%{startTime: 1_700_000_000_000, endTime: 1_700_090_000_000})

      iex> BinanceSpotRest.Validators.StartTimeEndTimeRange24h.validate(%{startTime: 1_700_000_000_000, endTime: nil})
      :ok

      iex> BinanceSpotRest.Validators.StartTimeEndTimeRange24h.validate(%{startTime: nil, endTime: 1_700_000_500_000})
      :ok

      iex> BinanceSpotRest.Validators.StartTimeEndTimeRange24h.validate(%{startTime: nil, endTime: nil})
      :ok
  """

  @max_interval_ms 86_400_000

  @behaviour Valpa.CustomValidator

  @impl true
  def validate(%{startTime: start_time, endTime: end_time} = map)
      when is_integer(start_time) and is_integer(end_time) do
    start_adj = adjust_time(start_time)
    end_adj = adjust_time(end_time)
    interval = end_adj - start_adj

    cond do
      interval < 0 ->
        {:error,
         Valpa.Error.new(
           validator: :timeRange24h,
           value: map,
           criteria: %{comparison: :start_before_end},
           text:
             ~s/expected: `endTime` to be greater than or equal to `startTime`, got: startTime: #{inspect(start_time)}, endTime: #{inspect(end_time)}/
         )}

      interval > @max_interval_ms ->
        {:error,
         Valpa.Error.new(
           validator: :timeRange24h,
           value: map,
           criteria: %{limit_ms: @max_interval_ms},
           text:
             ~s/expected: The time interval between `startTime` and `endTime` cannot exceed 24 hours, got: startTime: #{inspect(start_time)}, endTime: #{inspect(end_time)}/
         )}

      true ->
        :ok
    end
  end

  def validate(%{startTime: nil} = _map), do: :ok
  def validate(%{endTime: nil} = _map), do: :ok

  # Adjust a timestamp: if the value is less than 100,000,000,000 then assume it is in seconds and convert to ms.
  defp adjust_time(time) when is_integer(time) do
    if time < 100_000_000_000, do: time * 1000, else: time
  end
end
