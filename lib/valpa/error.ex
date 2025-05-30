defmodule Valpa.Error do
  @moduledoc """
  Validation error.
  """

  defexception [:validator, :value, :map_key, :criteria, :__trace__]

  @type t :: %__MODULE__{
          validator: atom(),
          value: any(),
          map_key: atom() | nil,
          criteria: any() | nil,
          __trace__: any() | nil
        }

  @impl true
  def message(%{
        validator: validator,
        value: value,
        map_key: map_key,
        criteria: criteria,
        __trace__: trace
      }) do
    trace_str = format_trace(trace)

    """
    expected: #{inspect(validator)}#{if(criteria, do: " of #{inspect(criteria)}")}, got: #{inspect(value)}#{if(map_key, do: " for map key #{inspect(map_key)}")}
    #{trace_str}
    """
  end

  defp format_trace(trace) do
    case trace do
      {:current_stacktrace, tr} -> Exception.format_stacktrace(tr)
      tr when is_list(tr) -> Exception.format_stacktrace(tr)
      _ -> "No stacktrace available"
    end
  end

  defp capture_trace() do
    {:current_stacktrace, trace} = Process.info(self(), :current_stacktrace)
    Enum.drop(trace, 1)
  end

  def new(fields) do
    %{struct(__MODULE__, fields) | __trace__: capture_trace()}
  end

  def set_map_key(%__MODULE__{} = error, map_key) do
    %{error | map_key: map_key}
  end
end
