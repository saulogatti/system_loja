# Minimal Starter Skill for Cloud Agents

## When to Use

Use this skill at the start of any task to set up the environment quickly,
run the app, and validate changes by code area without wasting time on
random attempts.

## Preflight (2-3 minutes)

1. Check versions and devices:
   - `flutter --version`
   - `flutter devices`
2. Install dependencies:
   - `flutter pub get`
3. Generate code if the branch already includes changes to `freezed`, `json_serializable`,
   Drift, or AutoRoute:
   - `dart run build_runner build`
4. Run a quick sanity check:
   - `dart analyze`

## Login, Authentication, and Permissions

- **No backend login is required** to start the application in this project.
- The app runs locally with embedded SQLite/Drift and no external API.
- For permission scenarios, use the user area (`Settings > Users`)
  and the `administrador` and `usuarioComum` levels.
- If the app requires a password at startup, this is controlled by a local setting
  (`AppSettings.exigirSenha`), not by an external identity provider.

## Feature Flags / Toggles (What Is Available Here)

- There is no central remote feature-flag service.
- The practical equivalent is the set of toggles persisted in `AppSettings` (notifications,
  theme, security, backup, etc.).
- Practical ways to change behavior:
  - Through the UI: `Settings` (preferred for manual validation).
  - Through code/tests: `AppSettings.createDefaultSettings().copyWith(...)` and
    `updateAppSettings(...)` in the configuration repository.
- To restore a known state, use “restore defaults” on the settings screen or
  clear local cache data during controlled testing.

## Run the Application (Cloud)

### Option A (recommended for Cloud agents): web-server

1. Start the app:
   - `flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0`
2. Confirm that `web/sqlite3.wasm` and `web/drift_worker.js` exist (required
   for Drift on the Web).

### Option B: Linux desktop

- `flutter run -d linux`

## Test Workflows by Code Area

### 1) `lib/core/models` and Serialization

Use this when changing JSON models, field validation, or utility extensions.

Workflow:
1. Run code generation (if there is `@JsonSerializable`):
   - `dart run build_runner build`
2. Run focused tests:
   - `flutter test test/json_serialization_test.dart`
   - `flutter test test/validators_test.dart`

Completion criteria:
- JSON round-tripping works, and critical validations have no regressions.

### 2) `lib/data/database` and Drift DAOs

Use this when changing tables, DAOs, mappings, queries, or persistence
behavior.

Workflow:
1. Run Drift code generation:
   - `dart run build_runner build`
2. Run focused database tests:
   - `flutter test test/category_dao_test.dart`
   - `flutter test test/invoice_dao_test.dart`
   - `flutter test test/database_helper_test.dart`

Completion criteria:
- DAO tests pass, and the main CRUD/query operations remain consistent.

### 3) `lib/domain/repository` and Interfaces (`lib/core/interface`)

Use this when changing business rules, `ResultStatus` returns, inter-layer
integration, or contracts.

Workflow:
1. Run the suite related to the changed domain (examples):
   - `flutter test test/sql_data_storage_test.dart`
   - `flutter test test/product_exception_test.dart`
2. Verify that errors are returned through `ResultStatus` (not as exceptions across layers).
   Repositories use internal `try/catch` blocks and return
   `ResultStatus.error(mensagemErroRepositorio(...))` — they never rethrow.

Completion criteria:
- No business-rule regressions and no broken repository/DAO contracts.

### 4) `lib/screens/**` (UI, BLoC/Cubit, widgets, routes)

Use this when changing screens, Freezed events/states, navigation, or visual components.

Workflow:
1. Run code generation when changing Freezed/AutoRoute:
   - `dart run build_runner build`
2. Run focused UI/widget tests:
   - `flutter test test/loading_overlay_test.dart`
   - `flutter test test/product_category_widget_test.dart`
   - `flutter test test/cliente_screen_search_test.dart`
3. Validate manually with the app running:
   - navigate through the changed area
   - run the happy path and one error scenario
   - confirm messages and visual feedback

Completion criteria:
- The screen works end to end, and the UI state correctly reflects the BLoC/Cubit state.

### 5) Startup and DI (`lib/main.dart`, `lib/application/app_injection.dart`, routes)

Use this when changing bootstrap, dependency registration, or the router.

Workflow:
1. Start the app (`web-server` or `linux`) and verify that it initializes without errors.
2. Run a navigation smoke test:
   - open Home
   - navigate to Registration, Sales, and Settings
   - return to Home without a crash

Completion criteria:
- The app starts successfully and resolves the expected dependencies/routes.

## Recommended Minimum Sequence per Task

1. `flutter pub get`
2. `dart run build_runner build` (when applicable)
3. Focused tests for the changed area
4. `dart analyze`
5. Brief manual validation in the app (for visual changes or user flows)

## Known Repository Limitations

- Some tests have pre-existing failures; prioritize suites directly
  related to the changed scope.
- The `test/validators_test.dart` suite is known to be stable for sanity checks.

## Updating This Skill with New Testing/Runbook Tips

Whenever you discover a command, workaround, or validation workflow that
saves meaningful time:

1. Add the information to the section for the **affected area** (models, database,
   repository, screens, or bootstrap).
2. Include the **exact command**, **when to use it**, and the **expected success signal**.
3. If it replaces an old step, remove the obsolete step in the same change.
4. Keep this skill short and operational (avoid long theory).

Rule of thumb: if a new agent would have difficulty running/testing without
the information, add it to this skill.
