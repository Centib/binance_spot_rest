defmodule Valpa.Error do
  @moduledoc """
  Validation error.
  """

  defexception [:validator, :value, :field, :criteria, :__trace__]

  @type t :: %__MODULE__{
          validator: atom() | nil,
          value: any() | nil,
          field: atom() | nil,
          criteria: any() | nil,
          __trace__: any() | nil
        }

  @impl true
  def message(%{
        validator: validator,
        value: value,
        field: field,
        criteria: criteria,
        __trace__: trace
      }) do
    trace_str = format_trace(trace)

    """
    expected: #{inspect(validator)}#{if(criteria, do: " of #{inspect(criteria)}")}, got: #{inspect(value)}#{if(field, do: " for field #{inspect(field)}")}
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

  def at(%__MODULE__{} = error, field) do
    %{error | field: field}
  end
end
