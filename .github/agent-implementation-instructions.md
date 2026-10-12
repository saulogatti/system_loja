---
description: Practical guidance for implementation and fixes in System Loja
applyTo: "**"
---

# Implementation Agent Instructions - System Loja

This file defines expectations for implementations, fixes, and refactoring in the project.

## 1) Architecture and Flow

- UI is in `lib/screens/`.
- Main flow: Screen (Bloc/Cubit) -> Interface (`lib/core/interface/`) -> Repository (`lib/domain/repository/`) -> Drift DAO (`lib/data/database/dao/`) -> SQLite.
- **Clean Architecture is required**: keep the domain (`lib/core/`) free of unnecessary dependencies on the data layer; place DTOs, JSON, and Drift in `lib/data/`; place repository implementations in `lib/domain/`. Large refactors are acceptable to preserve these boundaries (see `.github/copilot-instructions.md` for details).
- Dependency injection uses `GetIt` via `setupAppInjection()`.
- Navigation uses `auto_route` in `lib/screens/route/route_app.dart`.

## 2) Persistence and Compatibility

- Main database: `AppDatabase` with `schemaVersion => 12`.
- System database: `SystemDatabase` with `schemaVersion => 1`.
- Drift is the primary persistence mechanism. Use JSON DTOs in `lib/data/entry/` when needed. There is no `lib/core/managers/`; new features follow Interface + Repository + DAO.

Rules:

- **Backward compatibility is not required** while the app is under development: JSON contracts, models, and schemas may be changed when required by the architecture; update generated code, Drift, and tests in the affected scope.
- When changing a Drift schema, update `schemaVersion` and the migration strategy in the correct database.

## 3) Error Handling and Contracts

- The official return type is `ResultStatus<R, E>` (`lib/core/utils/result_status.dart`, which uses `package:meta`).
- Do not introduce `OperationResult`, `Either`, or alternative contracts without prior agreement.
- Do not propagate exceptions between Interface and Repository; return `ResultStatus`. Repositories use internal `try/catch` blocks and return `ResultStatus.error(mensagemErroRepositorio(error, contexto: '...'))` with user-friendly messages (see `lib/core/utils/repository_error_mapper.dart`).
- The presentation layer (BLoC/Cubit/Screen) does **not** wrap repository calls in `try/catch`; it uses `when` or `switch` on `ResultStatus`. In the UI, `try/catch` is reserved for local operations (file picker, writing to `File`) that do not use the repository contract.

## 4) Code Conventions

- Drift:
  - table: `XxxRecords`
  - row: `XxxRecord`
  - DAO: `XxxDao`
- **Do not** use `@UseRowClass` with entities from `lib/core/models/`; map `XxxRecord` to the domain in `lib/data/database/mapper/` or in the DAO/repository.
- `SystemDatabase` accepts an optional `QueryExecutor` in its constructor for in-memory database tests.
- `CacheManager` is registered through `GetIt` (DI); do not use `CacheManager.instance`. Repositories receive it through constructor injection.
- Code is in English.
- Documentation and comments (`///`) are in English.

## 5) Build, Code Generation, and Validation

Always run the following when applicable:

```bash
flutter pub get
dart run build_runner build
dart analyze
flutter test
```

Run build_runner after changes to:

- `@freezed` declarations
- `@JsonSerializable` declarations
- Drift (`@DriftDatabase`, `@DriftAccessor`, tables, and DAOs)
- Routes (`@RoutePage` / AutoRoute)

## 6) Web and Cross-Platform Support

- For Drift to work on the Web, keep `web/sqlite3.wasm` and `web/drift_worker.js`.
- Avoid OS-specific solutions without a fallback for Windows/Linux/Web.

## 7) Completion Checklist

- [ ] The implementation follows the layer flow (Screen -> Interface -> Repository -> DAO).
- [ ] Contracts return `ResultStatus<R, E>`.
- [ ] Schema changes include a migration and version update.
- [ ] Build runner has been run when required.
- [ ] `dart analyze` reports no new errors caused by the change.
- [ ] Tests for the affected scope have been run.
- [ ] Comments and documentation follow project standards.
