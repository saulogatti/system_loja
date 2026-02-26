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

## Big Picture / Arquitetura

- App Flutter multiplataforma (Windows/macOS/iOS/Android) com UI em `lib/screens/`.
- Fluxo principal: **Screen (Bloc/Cubit)** → **Interface** (`lib/core/interface/`) → **Repository** (`lib/core/repository/`) → **DAO Drift** (`lib/data/database/dao/`) → SQLite.
- Código legado em `lib/core/managers/` e configuração em JSON ainda em uso pontual (`ConfigurationRepository`). Não remover sem validar impacto.
- **DI**: GetIt com bootstrap síncrono em `setupAppInjection()` chamado no `main()`.
- **Navegação**: `auto_route` com root router em `lib/screens/route/route_app.dart` e gerado em `route_app.gr.dart`.
- **Dois bancos Drift**: `AppDatabase` (`lib/data/database/app_database.dart`, schemaVersion 10) e `SystemDatabase` (`lib/data/database/system_database.dart`, schemaVersion 2).
- Dependências centrais: `drift`, `flutter_bloc`, `freezed`, `json_serializable`, `auto_route`, `get_it`.

## Padrões do projeto

- Resultado de operações: `ResultStatus<R, E>` em `lib/core/utils/command_result.dart` — usar `isSuccessful`, `hasError`, `asSuccess`, `asError` e `when(...)`. Nunca lançar exceções através das camadas; nunca usar `ExecutionResult`.
- Drift: em várias tabelas o domínio é ligado via `@UseRowClass(...)` (ex.: `customer_records.dart`, `products_records.dart`). Convenção: tabela `XxxRecords`, linha gerada `XxxRecord`, DAO `XxxDao`.
- Código em inglês; documentação e comentários com `///` em português.

## Checklist antes de concluir alteração

- Se mudou schema Drift: atualizar `schemaVersion` e estratégia de migração no banco correto.
- Se mudou rotas/DI: conferir `setupAppInjection()` e router usado em `MaterialApp.router`.
- Se mudou código com geração: executar build_runner e revisar arquivos gerados.
- Não migrar/remover fluxo legado (`core/managers`) sem confirmar uso atual em repositório/interface/UI.

## Padrão de commits

- Formato: `<tipo>: <descrição concisa>`
- Tipos: `feat`, `fix`, `docs`, `style`, `refactor`, `test`
- Mensagem em português; incluir nome das classes alteradas quando fizer sentido.
- Exemplo: `fix: Corrigir bug na navegação do menu (MenuNavigator)`
