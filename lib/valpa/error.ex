defmodule Valpa.Error do
  @moduledoc """
  Validation error.
  """

  defexception [:validator, :value, :map_key, :criteria, :stacktrace]

  defp stacktrace() do
    {:current_stacktrace, trace} = Process.info(self(), :current_stacktrace)
    Enum.drop(trace, 1)
  end

  defp format_stacktrace(stacktrace) do
    case stacktrace do
      {:current_stacktrace, trace} -> Exception.format_stacktrace(trace)
      trace when is_list(trace) -> Exception.format_stacktrace(trace)
      _ -> "No stacktrace available"
    end
  end

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

  def new(%{validator: validator, value: value, map_key: map_key, criteria: criteria}) do
    %__MODULE__{
      validator: validator,
      value: value,
      map_key: map_key,
      criteria: criteria,
      stacktrace: stacktrace()
    }
  end

  def new(%{validator: validator, value: value, criteria: criteria}) do
    %__MODULE__{
      validator: validator,
      value: value,
      map_key: nil,
      criteria: criteria,
      stacktrace: stacktrace()
    }
  end

  @type t :: %__MODULE__{
          validator: atom(),
          value: any(),
          map_key: atom() | nil,
          criteria: any() | nil,
          stacktrace: any() | nil
        }
end
