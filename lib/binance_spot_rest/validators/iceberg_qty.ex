defmodule BinanceSpotRest.Validators.IcebergQty do
  @moduledoc """
  Validator for the `icebergQty` field.

  Rules:
    - `icebergQty` is optional.
    - If present, `icebergQty` must be a Decimal.
    - If present, `icebergQty` is only allowed when `timeInForce` is `:GTC` (or `nil`).
    - The `icebergQty` value must be less than the `quantity` value.

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

  @behaviour Valpa.CustomValidator

  @allowed_time_in_force BinanceSpotRest.Enums.TimeInForce._GTC()

  @validator :icebergQty

  @impl true
  def validate(%{} = map) do
    validate(map, :icebergQty, :timeInForce, :quantity)
  end

  defp validate(iceberg_qty, time_in_force, quantity) when not is_nil(iceberg_qty) do
    with :ok <- validate_iceberg_qty_type(iceberg_qty),
         :ok <- validate_time_in_force(time_in_force),
         :ok <- validate_iceberg_qty_value(iceberg_qty, quantity) do
      :ok
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp validate(_, _, _), do: :ok

  def validate(map, iceberg_qty_key, time_in_force_key, quantity_key) do
    validate(
      Map.get(map, iceberg_qty_key),
      Map.get(map, time_in_force_key),
      Map.get(map, quantity_key)
    )
  end

  defp validate_iceberg_qty_type(%Decimal{}), do: :ok

  defp validate_iceberg_qty_type(iceberg_qty),
    do:
      {:error,
       Valpa.Error.new(
         validator: @validator,
         value: iceberg_qty,
         field: :icebergQty,
         criteria: %{type: :decimal},
         text: "`icebergQty` must be a Decimal."
       )}

  defp validate_time_in_force(nil), do: :ok
  defp validate_time_in_force(@allowed_time_in_force), do: :ok

  defp validate_time_in_force(tif),
    do:
      {:error,
       Valpa.Error.new(
         validator: @validator,
         value: tif,
         field: :timeInForce,
         criteria: %{allowed: :GTC},
         text: "`icebergQty` is only allowed when `timeInForce` is :GTC, not #{inspect(tif)}."
       )}

  defp validate_iceberg_qty_value(_iceberg_qty, nil),
    do:
      {:error,
       Valpa.Error.new(
         validator: @validator,
         value: nil,
         field: :quantity,
         criteria: :required,
         text: "`icebergQty` requires `quantity` to be set."
       )}

  defp validate_iceberg_qty_value(%Decimal{} = iceberg_qty, %Decimal{} = quantity) do
    case Decimal.compare(iceberg_qty, quantity) do
      :lt ->
        :ok

      _ ->
        {:error,
         Valpa.Error.new(
           validator: @validator,
           value: iceberg_qty,
           field: :icebergQty,
           criteria: %{less_than: :quantity},
           text:
             "`icebergQty` must be less than the `quantity` value (got icebergQty=#{iceberg_qty}, quantity=#{quantity})."
         )}
    end
  end
end
