# System Loja - Copilot Instructions

## Build and Test
- Instalar dependências: `flutter pub get`.
- Rodar codegen quando houver alteração em `@freezed`, `@JsonSerializable`, Drift (`@DriftDatabase`, `@DriftAccessor`, tabelas/DAOs) ou `auto_route` (`@RoutePage`):
  - `dart run build_runner build --delete-conflicting-outputs`
- Executar app: `flutter run -d windows`, `flutter run -d chrome` ou `flutter run -d linux`.
- Testes: `flutter test` e `flutter test test/<arquivo>_test.dart`.
- Qualidade: `dart analyze` e `dart format --set-exit-if-changed .`.

## Architecture
- App Flutter multiplataforma com UI em `lib/screens/`.
- Fluxo principal: **Screen (Bloc/Cubit)** -> **Interface** (`lib/core/interface/`) -> **Repository** (`lib/core/repository/`) -> **DAO Drift** (`lib/data/database/dao/`) -> SQLite.
- DI com `GetIt` via `setupAppInjection()` no `main()`.
- Navegação com `auto_route` em `lib/screens/route/route_app.dart` (gerado em `route_app.gr.dart`).
- Existem dois bancos Drift:
  - `AppDatabase` (`lib/data/database/app_database.dart`) com `schemaVersion => 11`.
  - `SystemDatabase` (`lib/data/database/system_database.dart`) com `schemaVersion => 1`.

## Conventions
- Retorno de operações usa `ResultStatus<R, E>` (`lib/core/utils/command_result.dart`) com `isSuccessful`, `hasError`, `asSuccess`, `asError` e `when(...)`.
- Não propagar exceções entre camadas de interface/repositório; retornar `ResultStatus`.
- Drift: usar convenção tabela `XxxRecords`, linha `XxxRecord`, DAO `XxxDao`.
- Reutilizar `@UseRowClass(...)` nas tabelas Drift quando aplicável para reduzir conversões manuais.
- Código em inglês; documentação e comentários com `///` em português.
- Formato de commit: `<tipo>: <descrição concisa>`.
- Tipos de commit: `feat`, `fix`, `docs`, `style`, `refactor`, `test`.
- Mensagem de commit em português; incluir nome da classe alterada quando fizer sentido.

## Pitfalls
- Há código legado em `lib/core/managers/` e configuração em JSON ainda em uso pontual. Não remover sem validar impacto.
- Em mudanças de schema Drift, atualizar `schemaVersion` e estratégia de migração no banco correto.
- No Web, Drift depende de `web/sqlite3.wasm` e `web/drift_worker.js`.
- Existem alguns testes com falhas pré-existentes no repositório; valide o escopo alterado antes de tratar falhas fora da tarefa.