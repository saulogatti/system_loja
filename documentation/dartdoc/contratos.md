# Contracts

Interfaces in `lib/core/interface/` consumed by the presentation layer.

The UI resolves `appInjection.get<IXxxRepository>()` and handles the result with `when`/`switch` on `ResultStatus` — without `try/catch` around repository calls.

Guide: `docs/INTERFACES_ARCHITECTURE.md`.
