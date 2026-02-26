# AGENTS.md

## Cursor Cloud specific instructions

### Project overview

System Loja is a Flutter multiplatform store management application (customers, products, invoices, company, categories, settings). It uses Drift ORM (SQLite), BLoC/Cubit for state management, and `build_runner` for code generation. See `README.md` for full architecture details.

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

- **Code generation is mandatory** after modifying models, BLoC events/states, Drift tables, or AutoRoute definitions. Always run `dart run build_runner build --delete-conflicting-outputs` before analyzing, testing, or running.
- **Some tests have pre-existing failures** (missing `main` methods, uninitialized `WidgetsFlutterBinding`, unregistered `LogPrinterService`). The `validators_test.dart` suite (35 tests) passes cleanly; other test files have known issues in the repo.
- **Web platform** requires `web/sqlite3.wasm` and `web/drift_worker.js` for Drift ORM to work. These are committed in the repo.
- The `pubspec.yaml` has `sdk: ">=3.11.0"` — Flutter 3.41+ is required.
- **No external services** (no Docker, no backend API, no external database). SQLite is embedded via Drift.
- **Documentation and comments must be in Portuguese** per project convention.
