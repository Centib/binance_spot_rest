# Changelog

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

