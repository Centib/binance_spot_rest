defmodule Valpa.Error do
  @moduledoc """
  Validation error.
  """

  defexception [:validator, :value, :map_key, :criteria, :stacktrace]

  @type t :: %__MODULE__{
          validator: atom(),
          value: any(),
          map_key: atom() | nil,
          criteria: any() | nil,
          stacktrace: any() | nil
        }

  @impl true
  def message(%{
        validator: validator,
        value: value,
        map_key: map_key,
        criteria: criteria,
        stacktrace: stacktrace
      }) do
    stack_str = format_stacktrace(stacktrace)

    """
    expected: #{inspect(validator)}#{if(criteria, do: " of #{inspect(criteria)}")}, got: #{inspect(value)}#{if(map_key, do: " for map key #{inspect(map_key)}")}
    #{stack_str}
    """
  end

  defp format_stacktrace(stacktrace) do
    case stacktrace do
      {:current_stacktrace, trace} -> Exception.format_stacktrace(trace)
      trace when is_list(trace) -> Exception.format_stacktrace(trace)
      _ -> "No stacktrace available"
    end
  end

  defp stacktrace() do
    {:current_stacktrace, trace} = Process.info(self(), :current_stacktrace)
    Enum.drop(trace, 1)
  end

  def new(fields) do
    %{struct(__MODULE__, fields) | stacktrace: stacktrace()}
  end

  def set_map_key(%__MODULE__{} = error, map_key) do
    %{error | map_key: map_key}
  end
end
