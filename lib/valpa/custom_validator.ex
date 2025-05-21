defmodule Valpa.CustomValidator do
  @moduledoc """
  Behaviour for custom validators.
  """

  @callback validate(term) :: :ok | {:error, String.t()}
  @type validate :: (term -> :ok | {:error, String.t()})
  @type t :: module()

  def ensure_behaviour(validator) do
    exports = validator.module_info(:exports)

    validate_exported =
      Enum.any?(exports, fn {name, arity} -> name == :validate and arity == 1 end)

    unless validate_exported do
      raise ArgumentError,
            "Validator module #{inspect(validator)} does not implement Valpa.CustomValidator behaviour"
    end
  end
end
