# Changelog

## v0.2.0 (2025-09-30)

- **Breaking Change**: `recvWindow` parameter must now be provided as a **`Decimal` struct**.
  - Integer values (e.g., `5000`) are no longer accepted directly.
  - Must use `Decimal.new/1`, e.g. `Decimal.new("5000")`.
  - Precision is limited to **3 decimal places** in line with Binance API docs.
    - ✅ Valid: `Decimal.new("5000")`, `Decimal.new("123.456")`
    - ❌ Invalid: `5000`, `Decimal.new("123.4567")`
- Validation for `recvWindow` enforces both **range** (`0`–`60000`) and **precision**.
- Documentation and examples updated to reflect mandatory `Decimal` usage.
- **Migration Guide:**
  - **Before (v0.1.x):**
    ```elixir
    %Account.Query{
      recvWindow: 3000
    }
    ```
  - **After (v0.2.0):**
    ```elixir
    %Account.Query{
      recvWindow: Decimal.new("3000")
    }
    ```
  - If you need fractional precision (up to 3 decimals):
    ```elixir
    %Account.Query{
      recvWindow: Decimal.new("3000.123")
    }
    ```

## v0.1.3 (2025-09-17)

- Fixed dependency conflict for `credo`:
  - Restricted `credo` to `[:dev, :test]` with `runtime: false`
  - Prevents conflicts when used as a dependency in other projects
- No functional changes; fully backward compatible

## v0.1.2 (2025-09-04)

- Added **Architecture Guide** with detailed low-level workflow and pipeline examples
- Separated client request creation (`create_request/2`) from execution (`make_request/1`) in docs
- Improved documentation clarity for configuration, validation behavior, and pipeline usage
- Added link to Architecture Guide from main README
- Minor formatting and readability improvements in README and guides
- No breaking changes; fully backward compatible

## v0.1.1 (2025-09-03)

- Bumped `valpa` dependency to `~> 0.1.1`
- Validations now behave consistently with the latest Valpa
- **Stacktraces for validation errors are no longer shown in production**
- Minor internal improvements; no breaking changes

## v0.1.0 (2025-09-01)

- Initial public release
- Unified `request/2` function for all Spot endpoints
- Query structs for all endpoints (parameterized or empty)
- Built-in validation for query parameters
- Enum helpers for safe query building
- Configurable credentials via direct config or environment variables
- Testable and mockable request execution
- Supports high-level API (`request/1`) and low-level step chaining
- Documentation on HexDocs
