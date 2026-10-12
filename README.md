# System Loja

A cross-platform Flutter application for store management (customers, products, categories, company details, and invoices/sales), with local SQLite persistence through Drift.

## Overview

- UI in `lib/screens/`, using BLoC/Cubit (`flutter_bloc`).
- Main flow: **Screen** → **Interface** (`lib/core/interface/`) → **Repository** (`lib/domain/repository/`) → **Drift DAO** (`lib/data/database/dao/`) → SQLite.
- Dependency injection with `GetIt` via `setupAppInjection()` in `lib/application/app_injection.dart` — resolve dependencies with `appInjection.get<T>()`.
- Navigation with `auto_route` in `lib/screens/route/route_app.dart`.
- Return type between layers: `ResultStatus<R, E>` (`lib/core/utils/result_status.dart`, which uses `package:meta`).
- Repositories use internal `try/catch` blocks and return `ResultStatus.error(...)` with user-friendly messages via `mensagemErroRepositorio()` (`lib/core/utils/repository_error_mapper.dart`). The presentation layer **does not** wrap repository calls in `try/catch`; it uses `when` or `switch` on `ResultStatus`.
- **Data** layer (`lib/data/`): Drift, JSON DTOs/entries, conversions, caching, and mapping to models in `lib/core/models/` — it does **not** depend on `lib/domain/` or `lib/application/` (shared constants belong in `lib/core/` when needed).
- `CacheManager` is registered through `GetIt` (dependency injection) — **do not** use `CacheManager.instance`.

## Requirements

- Flutter `>=3.47.0` (as specified in `pubspec.yaml`).
- Dart SDK `>=3.13.0 <4.0.0`.

## Quick setup

```bash
git clone https://github.com/saulogatti/system_loja.git
cd system_loja
flutter pub get
dart run build_runner build
```

## Run the app

```bash
# Windows
flutter run -d windows

# Linux
flutter run -d linux

# Web (Chrome)
flutter run -d chrome

# Web (local server)
flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0
```

## Quality checks

```bash
# Code generation (required after changing Freezed/JsonSerializable/Drift/AutoRoute)
dart run build_runner build

# Static analysis
dart analyze

# Formatting
dart format --set-exit-if-changed .

# Tests
flutter test
flutter test test/<file>_test.dart

# API documentation (GitHub Pages)
dart doc -o docs/
```

## Architecture

### Drift databases

- `AppDatabase` (`lib/data/database/app_database.dart`) with `schemaVersion => 12`.
- `SystemDatabase` (`lib/data/database/system_database.dart`) with `schemaVersion => 1`.

### Persistence and DTOs

The store's primary persistence is **SQLite through Drift**. Serializable JSON DTOs live in `lib/data/entry/` and related locations when needed for import/export or occasional serialization — there is **no** `lib/core/managers/` directory, and JSON managers are not the standard pattern for new features.

### Important conventions

- Do not propagate exceptions between Interface/Repository; return `ResultStatus`. Repositories catch exceptions internally (`try/catch`) and return `ResultStatus.error(mensagemErroRepositorio(...))`. The presentation layer does not use `try/catch` for repository calls.
- Drift naming: table `XxxRecords`, generated row `XxxRecord`, DAO `XxxDao`. Drift rows do **not** use `@UseRowClass` with entities from `lib/core/`; domain mapping belongs in extensions/helpers (e.g. `lib/data/database/mapper/`) or DAOs/repositories, following the project pattern.
- Business models are in `lib/core/models/`.
- Code, documentation, and comments (`///`) are in English.
- `SystemDatabase` accepts an optional `QueryExecutor` in its constructor to simplify in-memory database tests.
- Use `auto_route` for page navigation; use `Navigator` only for dialogs, bottom sheets, and modals.

## Project structure at a glance

```text
lib/
  main.dart
  application/
    app_injection.dart   # GetIt / setupAppInjection()
  core/
    interface/           # contracts (e.g. I*Repository)
    constants/
    models/              # domain entities
    services/            # cross-cutting services (when applicable)
    utils/               # ResultStatus, repository_error_mapper, extensions
  domain/
    repository/          # repository implementations
    *.dart               # domain services (e.g. code generation)
  data/
    database/
      dao/
      table/
      extension/
      mapper/            # XxxRecord -> domain model
    entry/               # JSON DTOs (json_serializable)
    cache/
    converter/
    models/              # supporting persistence models
  screens/
    route/
test/
  support/               # helpers (e.g. AppDatabase tests without path_provider)
documentation/
  dartdoc/               # source pages for dart doc categories
  historico/             # historical material (not an implementation standard)
docs/                    # generated HTML (`dart doc -o docs/`) for GitHub Pages
```

## Important notes

- On the Web, Drift depends on `web/sqlite3.wasm` and `web/drift_worker.js`.
- Some tests in the repository have pre-existing failures; validate the changed scope first before addressing failures outside the task.
- Tests that instantiate `AppDatabase` on the VM can use `applicationSupportDirectory` and `tempDirectoryPath` (see `test/support/test_app_database.dart`) to avoid `path_provider` / `MissingPluginException`.

## API documentation (dartdoc)

Generate the HTML site published on GitHub Pages (the repository's `/docs` directory):

```bash
dart doc -o docs/
```

The output in `docs/` is a static site. To browse it locally, serve it over HTTP (search and the sidebar do not work with `file://`).

Sidebar categories are defined in `dartdoc_options.yaml` and the source pages in `documentation/dartdoc/`.

## Main documentation

- `CONTRIBUTING.md`
- `.github/copilot-instructions.md`
- `.github/instructions/dartcode.instructions.md`
- `AGENTS.md`
- `flutter_rules.md` (repository-specific conventions)
- `documentation/DRIFT_ARCHITECTURE.md`
- `documentation/DRIFT_MIGRATION.md`
- `documentation/INTERFACES_ARCHITECTURE.md`
- `documentation/VALIDATION_SYSTEM.md`
- `documentation/CODE_GENERATOR_USAGE.md`
- `documentation/TESTING_VALIDATION.md`
- `documentation/historico/` — historical notes and summaries (non-canonical)
