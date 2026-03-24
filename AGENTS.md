# AGENTS.md

## Cursor Cloud specific instructions

### Canonical workspace instructions

As instrucoes gerais do projeto ficam em `.github/copilot-instructions.md`.
Este arquivo existe apenas para complementar o ambiente Cursor Cloud.

### Prerequisites (already installed in snapshot)

- **Flutter 3.41.2** (Dart 3.11.0) at `/opt/flutter/bin` (added to `PATH` via `~/.bashrc`)
- **Linux desktop deps**: `libgtk-3-dev`, `ninja-build`, `libsqlite3-dev`, `clang`, `cmake`, `pkg-config`

### Key commands

| Action | Command |
|---|---|
| Install deps | `flutter pub get` |
| Code generation | `dart run build_runner build --delete-conflicting-outputs` |
| Lint | `dart analyze` |
| Format check | `dart format --set-exit-if-changed .` |
| Tests | `flutter test` |
| Run (web) | `flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0` |
| Run (linux desktop) | `flutter run -d linux` |
| List devices | `flutter devices` |

### Non-obvious caveats

- **Clean Architecture** is required: keep domain/core free of data-layer concerns where possible; DTOs, JSON codecs, and Drift stay in `lib/data/`. **`lib/data/` must not import `lib/domain/` or `lib/aplication/`** (shared literals/contracts live in `lib/core/` when needed). Large refactors for layering are acceptable (see `.github/copilot-instructions.md`).
- **Drift rows** are generated `XxxRecord` types; map to `lib/core/models/` in mappers/DAOs/repositories — do not tie tables to domain via `@UseRowClass(domainEntity)`.
- **Error handling**: repositories use `try/catch` internally and return `ResultStatus.error(mensagemErroRepositorio(...))` — never rethrow to BLoC/Cubit. The presentation layer does **not** wrap repository calls in `try/catch`; it pattern-matches on `ResultStatus`. See `lib/core/utils/repository_error_mapper.dart`.
- **`CacheManager`** is registered via `GetIt` (DI) — do **not** use `CacheManager.instance`. Repositories receive it through constructor injection.
- **`ResultStatus`** (`lib/core/utils/command_result.dart`) uses `package:meta`, not `freezed_annotation`.
- **No backward-compatibility requirement** while the app is in pre-production development—JSON formats, models, and DB schemas may change for clean structure; update codegen and tests accordingly.
- **Code generation is mandatory** after modifying models, BLoC events/states, Drift tables, or AutoRoute definitions.
- **Some tests have pre-existing failures** in the repository. Validate failures in the changed scope first before fixing unrelated suites.
- **Web platform** requires `web/sqlite3.wasm` and `web/drift_worker.js` for Drift ORM to work.
- The `pubspec.yaml` has `sdk: ">=3.11.0"` — Flutter 3.41+ is required.
- The project uses two Drift databases: `AppDatabase` (`schemaVersion => 11`) and `SystemDatabase` (`schemaVersion => 1`). `SystemDatabase` accepts an optional `QueryExecutor` for in-memory testing.
- **No external services** (no Docker, no backend API, no external database). SQLite is embedded via Drift.
- **Documentation and comments must be in Portuguese** per project convention.
- **Unit tests** that open `AppDatabase` on the VM should pass `applicationSupportDirectory` and `tempDirectoryPath` (see `test/support/test_app_database.dart`) so Drift does not call `path_provider` plugins unavailable in plain `flutter test`.
