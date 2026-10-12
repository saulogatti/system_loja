# System Loja - Copilot Instructions

Use these instructions as a quick supplement to `README.md`, `CONTRIBUTING.md`, `README_TESTING.md`, `AGENTS.md`, and the files in `.github/instructions/`. See `styleguide.md` for additional project rules and conventions. If you have questions, consult the documentation or ask a person.

## Build, test and lint

- Install dependencies: `flutter pub get`
- Run the app:
  - Windows: `flutter run -d windows`
  - Linux: `flutter run -d linux`
  - Chrome: `flutter run -d chrome`
  - Web server: `flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0`
- Run `dart run build_runner build` after changing classes with annotations: `@freezed`, `@JsonSerializable`, Drift (`@DriftDatabase`, `@DriftAccessor`, tables/DAOs), or `auto_route`.
- If generated files conflict, run `dart run build_runner clean` followed by `dart run build_runner build`.
- Static analysis: `dart analyze`
- Formatting check: `dart format --set-exit-if-changed .`
- Full test suite: `flutter test`
- A single test file: `flutter test test/<file>_test.dart`
- A specific test by name: `flutter test test/<file>_test.dart --plain-name "test name"`
- Tests by area, when useful for iteration: `flutter test test/screens/` or `flutter test test/core/`
- If there are legacy failures outside the task scope, validate tests for the changed scope first, before running the full suite.

## High-level architecture

- The app starts in `lib/main.dart`: it calls `setupAppInjection()`, registers dependencies in `GetIt`, and builds a `MaterialApp.router` with `RouteApp`.
- `setupAppInjection()` in `lib/application/app_injection.dart` is the central wiring point: it registers Drift databases, repositories, services, cache, router, and initial configuration loading through `IConfigurationRepository`.
- The UI is in `lib/screens/` and uses `flutter_bloc`, with BLoCs/Cubits injected at the top of the app. Navigation is declared in `lib/screens/route/route_app.dart` using `auto_route` and nested routes under `HostRoute`.
- The project's main flow is: **Screen/BLoC/Cubit -> interfaces in `lib/core/interface/` -> repositories in `lib/domain/repository/` -> Drift DAOs in `lib/data/database/dao/` -> SQLite**.
- Persistence is split between two databases:
  - `AppDatabase` (`lib/data/database/app_database.dart`): business data such as customers, products, categories, company details, invoices, and items.
  - `SystemDatabase` (`lib/data/database/system_database.dart`): users, logs, and system settings.
- `lib/data/` contains persistence and adaptation code: Drift tables, DAOs, `entry/` for serializable DTOs, `converter/`, `cache/`, and `mapper/` for converting `XxxRecord` rows into models in `lib/core/models/`.
- Primary persistence: Drift + repository. JSON DTOs belong in `lib/data/entry/` when needed. There is no `lib/core/managers/` directory; do not introduce JSON managers as the default for new features.

## Key conventions

- Code, comments, and `///` documentation are in English.
- The UI must not call DAOs directly or depend on concrete repository implementations; it consumes interfaces from `lib/core/interface/`.
- Repository operations return `ResultStatus<R, E>` (`lib/core/utils/result_status.dart`). Repositories catch exceptions internally and return `ResultStatus.error(...)`; the presentation layer handles the result with `when` or `switch`, without `try/catch` around repository calls.
- In the UI, `try/catch` is limited to local operations that do not go through a repository, such as file pickers or direct I/O.
- `lib/data/` must not import `lib/domain/` or `lib/application/`; keep persistence details below interfaces and repositories.
- Drift conventions: table `XxxRecords`, generated row `XxxRecord`, DAO `XxxDao`. Do not use `@UseRowClass` with entities from `lib/core/models/`; perform mapping in `mapper/`, `extension/`, a DAO, or a repository.
- See `documentation/DRIFT_ARCHITECTURE.md` for the step-by-step migration pattern. At minimum, add a `from-to` step in `MigrationStrategy.onUpgrade` and a corresponding schema snapshot under `drift_schemas/`.
- `CacheManager` and other shared services are injected through DI (`GetIt`); do not introduce parallel global singletons.
- In VM tests that instantiate `AppDatabase`, reuse the helpers in `test/support/test_app_database.dart` to avoid a dependency on `path_provider`.
- On the Web, Drift depends on `web/sqlite3.wasm` and `web/drift_worker.js`; do not remove these files when working on the web build.
- Commits follow the `<type>: <concise description>` format, using types such as `feat`, `fix`, `docs`, `refactor`, and `test`, with descriptions in English.

## MCP servers

- For web workflows (`flutter run -d chrome` or `flutter run -d web-server`), prefer using a Playwright MCP when available to validate navigation, UI states, forms, and visual regressions.
- Use the MCP to validate screen behavior in the browser; continue using `flutter test` for automated repository coverage.

## References

- `README.md`
- `CONTRIBUTING.md`
- `README_TESTING.md`
- `AGENTS.md`
- `.github/instructions/dartcode.instructions.md`
- `.github/instructions/dart-n-flutter.instructions.md`
- `documentation/DRIFT_ARCHITECTURE.md`
- `documentation/DRIFT_MIGRATION.md`
- `documentation/INTERFACES_ARCHITECTURE.md`
- `documentation/VALIDATION_SYSTEM.md`
- `documentation/CODE_GENERATOR_USAGE.md`
- `documentation/TESTING_VALIDATION.md`
- `documentation/historico/` (historical material; non-canonical)
- `flutter_rules.md`
