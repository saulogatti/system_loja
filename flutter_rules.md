# Flutter Development Rules (Project-Specific)

These are the consolidated, strict guidelines for Flutter and Dart development in this repository. Their purpose is to maintain consistency, clean architecture, and application performance.
For general information about Flutter and Dart development, see
[`.github\instructions\dart-n-flutter.instructions.md`](.github\instructions\dart-n-flutter.instructions.md).

## 1. Architecture and Organization (Clean Architecture)
* **Layered pattern:** Strictly follow the separation between `Presentation` (UI, Bloc/Cubit), `Domain` (business rules, entities), and `Data` (repositories, DTOs, DAOs, data sources).
* **Data-layer isolation:** The `data/` layer must **never** import classes from `domain/` or `application/`. Shared elements and contracts belong in `core/`.
* **Error handling and databases:**
    * Repositories must handle exceptions internally with `try/catch` and always return the `ResultStatus.error(...)` wrapper. Repository exceptions must never be propagated (thrown) to the Presentation layer.
    * The Presentation layer (BLoC) must **not** wrap repository calls in `try/catch`. It must pattern-match (check the status of) the returned `ResultStatus`.
    * Inject cache support (`CacheManager`) through `GetIt` or a constructor (never through hard-coded singletons using `.instance`).

## 2. State Management (Presentation)
* **Absolute rule:** Always use **BLoC / Cubit** (`flutter_bloc`) for UI state management.
* **Repositories and BLoC:** The BLoC consumes repository methods and converts user intentions (events) into the appropriate states by inspecting the immutable `ResultStatus`, retaining full control over presentation rules without interfering with data sources.

## 3. Navigation and Routing
* **Absolute rule:** Always use **`auto_route`** to manage project pages/screens.
* The classic `Navigator` is prohibited for ordinary transitions and is limited to temporary modals or very brief interactions without a permalink (such as dialogs and bottom sheets). Any route change requires running the code generator (build runner).

## 4. UI, Widgets, and Layout
* **Composition first (classic widgets):** Prefer **composition**, building small `StatelessWidget` classes instead of large methods that clutter a larger class.
* **Immutability:** Use the `const` keyword when initializing widgets and declarations at the call site to manage memory correctly with the Flutter engine.
* **Performance:**
    * For large renderable collections (dense grids and lists), always use the `.builder` constructors (`ListView.builder`, `GridView.builder`).
    * Move heavy synchronous processing and serialization that can cause frame jank into separate `compute()` calls to offload work from the UI's main native thread.
* **Responsive layouts and safe modal behavior:** Use flexible widgets such as `Expanded`/`Flexible` for consistent resizing on the same plane. Use `OverlayPortal` for overlays outside the local widget tree instead of mixing deep stacks into fixed modals.

## 5. Design and Material 3 (M3)
* **Centralized theming:** Configure the central color palette with `ColorScheme.fromSeed` through `ThemeData`.
* **Aesthetics and premium quality:** Use carefully readable font hierarchies and effects such as drop shadows or button glow; emulate interactive `WidgetStateProperty` behavior for desktop and web cursors.
* **Custom tokens:** When extending beyond the native Material palette, use `ThemeExtension`.
* **External images:** Any `Image.network` rendering without the preventive `loadingBuilder` and `errorBuilder` constructors is invalid.

## 6. Tools, Commands, and Local Conventions
* Run code generation from the terminal with `dart run build_runner build` after relevant changes to codegen inputs (JSON, Drift, BLoC states, routes).
* Write documentation descriptions and comments in English, consistent with the project.
* DI: `setupAppInjection()` in `lib/application/app_injection.dart`; resolve dependencies with `appInjection.get<T>()`.
* Primary persistence: Drift (`AppDatabase` schema 12 / `SystemDatabase` schema 1). JSON DTOs belong in `lib/data/entry/` when needed — there is no `managers/` directory.
