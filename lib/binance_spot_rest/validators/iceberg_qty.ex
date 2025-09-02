defmodule BinanceSpotRest.Validators.IcebergQty do
  @moduledoc """
  Internal
  
  Validator for the `icebergQty` field.

  Rules:

    - `icebergQty` is optional.
    - If present, it must be a Decimal.
    - It is only allowed when `timeInForce` is `:GTC` or `nil`.
    - It must be less than the `quantity` value.

  ## Examples

      iex> BinanceSpotRest.Validators.IcebergQty.validate(%{icebergQty: Decimal.new("0.5"), timeInForce: :GTC, quantity: Decimal.new("1.0")})
      :ok

      iex> {:error, %Valpa.Error{field: :timeInForce}} = BinanceSpotRest.Validators.IcebergQty.validate(%{icebergQty: Decimal.new("0.5"), timeInForce: :IOC, quantity: Decimal.new("1.0")})

      iex> {:error, %Valpa.Error{field: :icebergQty}} = BinanceSpotRest.Validators.IcebergQty.validate(%{icebergQty: Decimal.new("1.5"), timeInForce: :GTC, quantity: Decimal.new("1.0")})

      iex> BinanceSpotRest.Validators.IcebergQty.validate(%{icebergQty: Decimal.new("0.5"), quantity: Decimal.new("1.0")})
      :ok

      iex> {:error, %Valpa.Error{field: :icebergQty}} = BinanceSpotRest.Validators.IcebergQty.validate(%{icebergQty: "0.5", timeInForce: :GTC, quantity: Decimal.new("1.0")})

      iex> {:error, %Valpa.Error{field: :quantity}} = BinanceSpotRest.Validators.IcebergQty.validate(%{icebergQty: Decimal.new("0.5"), timeInForce: :GTC})

      iex> BinanceSpotRest.Validators.IcebergQty.validate(%{timeInForce: :GTC, quantity: Decimal.new("1.0")})
      :ok

      iex> BinanceSpotRest.Validators.IcebergQty.validate(%{})
      :ok
  """

  defmodule Ctx do
    @moduledoc false

    defstruct [:iceberg_qty, :time_in_force, :quantity]
  end

  @behaviour Valpa.CustomValidator

  @allowed_time_in_force BinanceSpotRest.Enums.TimeInForce._GTC()

  @validator :icebergQty

  # use in Valpa.Custom.validator - as default validation if keys are static
  @impl true
  def validate(%{} = map) do
    validate(map, :icebergQty, :timeInForce, :quantity)
  end

  # use in Valpa.Custom.validate - in custom function if keys are dynamic
  def validate(map, iceberg_qty_key, time_in_force_key, quantity_key) do
    do_validate(%Ctx{
      iceberg_qty: %{key: iceberg_qty_key, value: Map.get(map, iceberg_qty_key)},
      time_in_force: %{key: time_in_force_key, value: Map.get(map, time_in_force_key)},
      quantity: %{key: quantity_key, value: Map.get(map, quantity_key)}
    })
  end

  defp do_validate(%Ctx{} = ctx) when not is_nil(ctx.iceberg_qty.value) do
    with :ok <- validate_iceberg_qty_type(ctx),
         :ok <- validate_time_in_force(ctx),
         :ok <- validate_iceberg_qty_value(ctx) do
      :ok
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp do_validate(_), do: :ok

  defp validate_iceberg_qty_type(%Ctx{iceberg_qty: %{value: %Decimal{}}}), do: :ok

  defp validate_iceberg_qty_type(%Ctx{} = ctx),
    do:
      {:error,
       Valpa.Error.new(
         validator: @validator,
         value: ctx.iceberg_qty.value,
         field: ctx.iceberg_qty.key,
         criteria: %{type: :decimal},
         text: "`#{ctx.iceberg_qty.key}` must be a Decimal."
       )}

  defp validate_time_in_force(%Ctx{time_in_force: %{value: nil}}), do: :ok
  defp validate_time_in_force(%Ctx{time_in_force: %{value: @allowed_time_in_force}}), do: :ok

  defp validate_time_in_force(%Ctx{} = ctx),
    do:
      {:error,
       Valpa.Error.new(
         validator: @validator,
         value: ctx.time_in_force.value,
         field: ctx.time_in_force.key,
         criteria: %{allowed: :GTC},
         text:
           "`#{ctx.iceberg_qty.key}` is only allowed when `#{ctx.time_in_force.key}` is :GTC, not #{inspect(ctx.time_in_force.value)}."
       )}

  defp validate_iceberg_qty_value(%Ctx{quantity: %{value: nil}} = ctx),
    do:
      {:error,
       Valpa.Error.new(
         validator: @validator,
         value: nil,
         field: ctx.quantity.key,
         criteria: :required,
         text: "`#{ctx.iceberg_qty.key}` requires `#{ctx.quantity.key}` to be set."
       )}

  defp validate_iceberg_qty_value(
         %Ctx{
           iceberg_qty: %{value: %Decimal{}},
           quantity: %{value: %Decimal{}}
         } = ctx
       ) do
    case Decimal.compare(ctx.iceberg_qty.value, ctx.quantity.value) do
      :lt ->
        :ok

      _ ->
        {:error,
         Valpa.Error.new(
           validator: @validator,
           value: ctx.iceberg_qty.value,
           field: ctx.iceberg_qty.key,
           criteria: %{less_than: ctx.quantity.key},
           text:
             "`#{ctx.iceberg_qty.key}` must be less than the `#{ctx.quantity.key}` value (got #{ctx.iceberg_qty.key}=#{ctx.iceberg_qty.value}, #{ctx.quantity.key}=#{ctx.quantity.value})."
         )}
    end
  end
end
