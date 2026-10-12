---
description: Dart rules for System Loja (architecture, ResultStatus, and Drift)
applyTo: '**/*.dart'
---

# Dart Code Rules

## General guidelines

- Follow Effective Dart.
- Use `dart format`.
- Prioritize readability and simplicity.
- Avoid changes outside the task scope.

## Project conventions

- Code is in English.
- Comments and `///` documentation are in English.
- Layer flow: Screen -> Interface (`lib/core/interface/`) -> Repository (`lib/domain/repository/`) -> Drift DAO (`lib/data/database/dao/`).
- `lib/data/` must not import `lib/domain/` or `lib/application/`.
- Do not propagate exceptions between Interface and Repository. Repositories use internal `try/catch` blocks and return `ResultStatus.error(mensagemErroRepositorio(...))` with user-friendly messages (`lib/core/utils/repository_error_mapper.dart`). The presentation layer does not use `try/catch` for repository calls.
- Return `ResultStatus<R, E>` (`lib/core/utils/result_status.dart`, which uses `package:meta`).
- Register `CacheManager` through `GetIt` (DI); do not use `CacheManager.instance`.

## Drift

- Table: `XxxRecords`
- Row: `XxxRecord` (generated)
- DAO: `XxxDao`
- Do not couple tables to models in `lib/core/` with `@UseRowClass`; map records -> domain in a mapper/DAO/repository.
- When changing a schema, update `schemaVersion` / the migration in the correct database (before production, breaking changes are acceptable).

## Code generation

Run `dart run build_runner build` after changing:

- classes with `@freezed`
- classes with `@JsonSerializable`
- Drift tables/DAOs
- AutoRoute routes

## Quality

Before completing Dart changes, validate with:

```bash
dart analyze
flutter test
```
