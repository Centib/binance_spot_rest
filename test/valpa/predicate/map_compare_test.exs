defmodule Valpa.Predicate.MapCompareTest do
  @moduledoc false
  use ExUnit.Case, async: true

  alias Valpa.Predicate.Validator

  describe "map_compare_int_keys/2 and maybe_map_compare_int_keys/2" do
    @valid [
      {%{a: 1, b: 2}, {:<, :a, :b}},
      {%{a: 5, b: 5}, {:==, :a, :b}},
      {%{a: 10, b: 2}, {:>, :a, :b}},
      {%{a: 5, b: 5}, {:>=, :a, :b}},
      {%{a: 4, b: 5}, {:<=, :a, :b}},
      {%{a: 4, b: 5}, {:!=, :a, :b}},
      # nil or missing fields
      {%{a: nil, b: 2}, {:<, :a, :b}},
      {%{a: 1, b: nil}, {:<, :a, :b}},
      {%{}, {:<, :a, :b}}
    ]

    @invalid [
      {%{a: 3, b: 2}, {:<, :a, :b}},
      {%{a: 2, b: 2}, {:<, :a, :b}},
      {%{a: 2, b: 2}, {:!=, :a, :b}},
      {%{a: 1, b: 2}, {:>, :a, :b}},
      {%{a: 3, b: 5}, {:==, :a, :b}},
      # not integer
      {%{a: 1.0, b: 2}, {:<, :a, :b}},
      {%{a: 1, b: 2.0}, {:<, :a, :b}},
      {%{a: Decimal.new("1"), b: 2}, {:<, :a, :b}},
      {%{a: 1, b: Decimal.new("2")}, {:<, :a, :b}},
      {%{a: "1", b: 2}, {:<, :a, :b}},
      {%{a: 1, b: "2"}, {:<, :a, :b}},
      {%{a: true, b: 1}, {:<, :a, :b}},
      {%{a: 1, b: false}, {:<, :a, :b}}
    ]

    @maybe_valid [{nil, {:>, :a, :b}}, @valid]

    test "map_compare_int_keys returns true when integer comparison holds" do
      for {input, criteria} <- @valid,
          do: assert(Validator.map_compare_int_keys(input, criteria) == true)
    end

    test "map_compare_int_keys returns false when integer comparison fails" do
      for {input, criteria} <- @invalid,
          do: assert(Validator.map_compare_int_keys(input, criteria) == false)
    end

    test "maybe_map_compare_int_keys returns true when integer comparison holds" do
      for {input, criteria} <- @maybe_valid,
          do: assert(Validator.maybe_map_compare_int_keys(input, criteria) == true)
    end

    test "maybe_map_compare_int_keys returns false when integer comparison fails" do
      for {input, criteria} <- @invalid,
          do: assert(Validator.maybe_map_compare_int_keys(input, criteria) == false)
    end

    test "raises or fails for unsupported operator" do
      assert_raise FunctionClauseError, fn ->
        Validator.map_compare_int_keys(%{a: 1, b: 2}, {:invalid_op, :a, :b})
      end

      assert_raise FunctionClauseError, fn ->
        Validator.maybe_map_compare_int_keys(%{a: 1, b: 2}, {:invalid_op, :a, :b})
      end
    end
  end

  describe "map_compare_float_keys/2 and maybe_map_compare_float_keys/2" do
    @valid [
      {%{a: 1.0, b: 2.0}, {:<, :a, :b}},
      {%{a: 5.5, b: 5.5}, {:==, :a, :b}},
      {%{a: 10.1, b: 2.5}, {:>, :a, :b}},
      {%{a: 5.0, b: 5.0}, {:>=, :a, :b}},
      {%{a: 4.5, b: 5.0}, {:<=, :a, :b}},
      {%{a: 4.2, b: 5.1}, {:!=, :a, :b}},
      # nil or missing fields
      {%{a: nil, b: 2.0}, {:<, :a, :b}},
      {%{a: 1.0, b: nil}, {:<, :a, :b}},
      {%{}, {:<, :a, :b}}
    ]

    @invalid [
      {%{a: 3.5, b: 2.5}, {:<, :a, :b}},
      {%{a: 2.0, b: 2.0}, {:<, :a, :b}},
      {%{a: 2.0, b: 2.0}, {:!=, :a, :b}},
      {%{a: 1.0, b: 2.0}, {:>, :a, :b}},
      {%{a: 3.1, b: 5.9}, {:==, :a, :b}},
      # wrong type
      {%{a: 1, b: 2.0}, {:<, :a, :b}},
      {%{a: 1.0, b: 2}, {:<, :a, :b}},
      {%{a: Decimal.new("1.0"), b: 2.0}, {:<, :a, :b}},
      {%{a: 1.0, b: Decimal.new("2.0")}, {:<, :a, :b}},
      {%{a: "1.0", b: 2.0}, {:<, :a, :b}},
      {%{a: 1.0, b: "2.0"}, {:<, :a, :b}},
      {%{a: true, b: 1.0}, {:<, :a, :b}},
      {%{a: 1.0, b: false}, {:<, :a, :b}}
    ]

    @maybe_valid [{nil, {:>, :a, :b}}, @valid]

    test "map_compare_float_keys returns true when float comparison holds" do
      for {input, criteria} <- @valid,
          do: assert(Validator.map_compare_float_keys(input, criteria) == true)
    end

    test "map_compare_float_keys returns false when float comparison fails" do
      for {input, criteria} <- @invalid,
          do: assert(Validator.map_compare_float_keys(input, criteria) == false)
    end

    test "maybe_map_compare_float_keys returns true when float comparison holds" do
      for {input, criteria} <- @maybe_valid,
          do: assert(Validator.maybe_map_compare_float_keys(input, criteria) == true)
    end

    test "maybe_map_compare_float_keys returns false when float comparison fails" do
      for {input, criteria} <- @invalid,
          do: assert(Validator.maybe_map_compare_float_keys(input, criteria) == false)
    end

    test "raises or fails for unsupported operator" do
      assert_raise FunctionClauseError, fn ->
        Validator.map_compare_float_keys(%{a: 1.3, b: 2.4}, {:invalid_op, :a, :b})
      end

      assert_raise FunctionClauseError, fn ->
        Validator.maybe_map_compare_float_keys(%{a: 1.4, b: 2.5}, {:invalid_op, :a, :b})
      end
    end
  end

  describe "map_compare_decimal_keys/2 and map_compare_decimal_keys/2" do
    @valid [
      {%{a: Decimal.new("1.0"), b: Decimal.new("2.0")}},
      {%{a: Decimal.new("5.5"), b: Decimal.new("5.5")}},
      {%{a: Decimal.new("10.1"), b: Decimal.new("2.5")}},
      {%{a: Decimal.new("5.0"), b: Decimal.new("5.0")}},
      {%{a: Decimal.new("4.5"), b: Decimal.new("5.0")}},
      {%{a: Decimal.new("4.2"), b: Decimal.new("5.1")}},
      # nil or missing fields
      {%{a: nil, b: Decimal.new("2.0")}, {:<, :a, :b}},
      {%{a: Decimal.new("1.0"), b: nil}, {:<, :a, :b}},
      {%{}, {:<, :a, :b}}
    ]

    @invalid [
      {%{a: Decimal.new("3.5"), b: Decimal.new("2.5")}},
      {%{a: Decimal.new("2.0"), b: Decimal.new("2.0")}},
      {%{a: Decimal.new("2.0"), b: Decimal.new("2.0")}},
      {%{a: Decimal.new("1.0"), b: Decimal.new("2.0")}},
      {%{a: Decimal.new("3.1"), b: Decimal.new("5.9")}},
      # wrong type
      {%{a: 1.0, b: Decimal.new("2.0")}, {:<, :a, :b}},
      {%{a: Decimal.new("1.0"), b: 2.0}, {:<, :a, :b}},
      {%{a: 1, b: Decimal.new("2.0")}, {:<, :a, :b}},
      {%{a: Decimal.new("1.0"), b: 2}, {:<, :a, :b}},
      {%{a: "1.0", b: Decimal.new("2.0")}, {:<, :a, :b}},
      {%{a: Decimal.new("1.0"), b: "2.0"}, {:<, :a, :b}},
      {%{a: true, b: Decimal.new("1.0")}, {:<, :a, :b}},
      {%{a: Decimal.new("1.0"), b: false}, {:<, :a, :b}}
    ]

    @maybe_valid [{nil, {:>, :a, :b}}, @valid]

    test "map_compare_decimal_keys returns true when decimal comparison holds" do
      for {input, criteria} <- @valid,
          do: assert(Validator.map_compare_decimal_keys(input, criteria) == true)
    end

    test "map_compare_decimal_keys returns false when decimal comparison fails" do
      for {input, criteria} <- @invalid,
          do: assert(Validator.map_compare_decimal_keys(input, criteria) == false)
    end

    test "maybe_map_compare_decimal_keys returns true when decimal comparison holds" do
      for {input, criteria} <- @maybe_valid,
          do: assert(Validator.maybe_map_compare_decimal_keys(input, criteria) == true)
    end

    test "maybe_map_compare_decimal_keys returns false when decimal comparison fails" do
      for {input, criteria} <- @invalid,
          do: assert(Validator.maybe_map_compare_decimal_keys(input, criteria) == false)
    end

    %{a: Decimal.new("1.0"), b: Decimal.new("2.0")}

    test "raises or fails for unsupported operator" do
      assert_raise FunctionClauseError, fn ->
        Validator.map_compare_decimal_keys(
          %{a: Decimal.new("1.0"), b: Decimal.new("2.0")},
          {:invalid_op, :a, :b}
        )
      end

      assert_raise FunctionClauseError, fn ->
        Validator.maybe_map_compare_decimal_keys(
          %{a: Decimal.new("1.0"), b: Decimal.new("2.0")},
          {:invalid_op, :a, :b}
        )
      end
    end
  end
end
