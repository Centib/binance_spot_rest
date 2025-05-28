defmodule BinanceSpotRest.Validators.TimeZone do
  @moduledoc """
  Validates `timeZone` values.

  Supported formats:
    - Hours only (e.g. "0", "8", "4", "-1")
    - Hours and minutes (e.g. "-1:00", "05:45", "+10:30")

  The accepted range is strictly from -12:00 to +14:00 (inclusive).
  """

  @behaviour Valpa.CustomValidator

  # -720 minutes
  @min_minutes -12 * 60
  # 840 minutes
  @max_minutes 14 * 60

  defp valid?(tz) when is_binary(tz) do
    cond do
      # Case: Only hours (optional sign)
      Regex.match?(~r/^[+-]?\d{1,2}$/, tz) ->
        case Integer.parse(tz) do
          {hours, ""} ->
            offset = hours * 60
            in_range?(offset)

          _ ->
            false
        end

      # Case: Hours and minutes (optional sign)
      Regex.match?(~r/^[+-]?\d{1,2}:[0-5]\d$/, tz) ->
        case Regex.run(~r/^([+-]?\d{1,2}):([0-5]\d)$/, tz) do
          [_, hour_str, minute_str] ->
            {hours, ""} = Integer.parse(hour_str)
            {minutes, ""} = Integer.parse(minute_str)
            # If the string starts with "-", then minutes are negative.
            offset = hours * 60 + if String.starts_with?(tz, "-"), do: -minutes, else: minutes
            in_range?(offset)

          _ ->
            false
        end

      true ->
        false
    end
  end

  defp valid?(_), do: false

  defp in_range?(offset_minutes) do
    offset_minutes >= @min_minutes and offset_minutes <= @max_minutes
  end

  # TODO: consider add message to Valpa, or don't use custom validators - rethink!
  # defp message(tz) do
  #   ~s/Expected: timeZone value (e.g. "0", "8", "4", "-1"), (e.g. "-1:00", "05:45", "+10:30"), from -12:00 to +14:00 (inclusive), got: #{inspect(tz)}/
  # end

  @doc """
  Returns :ok if `tz` is a valid time zone, {:error, msg} otherwise.

  ## Examples

      iex> Binance.Validators.TimeZone.validate("05:45")
      :ok

      iex> Binance.Validators.TimeZone.validate("-1")
      :ok

      iex> {:error, _} = Binance.Validators.TimeZone.validate("15")

      iex> {:error, _} = Binance.Validators.TimeZone.validate("invalid")
  """
  # TODO: consider add map_key in Valpa, not here. (maybe add one more new with 3 fields)
  @impl Valpa.CustomValidator
  def validate(value) do
    if valid?(value) do
      :ok
    else
      {:error, Valpa.Error.new(%{
        validator: :time_zone,
        value: value,
        map_key: :timeZone,
        criteria: :range_or_format
      })}
    end
  end
end
