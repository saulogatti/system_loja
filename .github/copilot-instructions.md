# System Loja - Copilot Instructions

Instrucoes gerais para o agente no workspace.

## Build and Test
- Instalar dependencias: `flutter pub get`.
- Rodar codegen quando houver alteracao em `@freezed`, `@JsonSerializable`, Drift (`@DriftDatabase`, `@DriftAccessor`, tabelas/DAOs) ou `auto_route` (`@RoutePage`):
  - `dart run build_runner build --delete-conflicting-outputs`
- Executar app: `flutter run -d windows`, `flutter run -d chrome` ou `flutter run -d linux`.
- Testes: `flutter test` e `flutter test test/<arquivo>_test.dart`.
- Qualidade: `dart analyze` e `dart format --set-exit-if-changed .`.

## Arquitetura
- Fluxo principal: Screen (Bloc/Cubit) -> Interface (`lib/core/interface/`) -> Repository (`lib/domain/repository/`) -> DAO Drift (`lib/data/database/dao/`) -> SQLite.
- DI com GetIt via `setupAppInjection()` em `lib/aplication/app_injection.dart` (chamado no `main()`).
- Navegacao com `auto_route` em `lib/screens/route/route_app.dart` (gerado em `route_app.gr.dart`).
- Bancos Drift:
  - `AppDatabase` (`lib/data/database/app_database.dart`) com `schemaVersion => 12`.
  - `SystemDatabase` (`lib/data/database/system_database.dart`) com `schemaVersion => 1`.

## Conventions
- Seguir Clean Architecture com fronteiras de camada explicitas.
- Domínio/core (`lib/core/`): modelos de negocio e contratos.
- Dados (`lib/data/`): Drift, DAOs, DTOs e mapeamento. Nao importar `lib/domain/` nem `lib/aplication/` a partir de `lib/data/`.
- Apresentacao (`lib/screens/`): nao envolver chamadas ao repositorio em `try/catch`; tratar `ResultStatus` com `when`/`switch`.
- Retornar `ResultStatus<R, E>` (`lib/core/utils/command_result.dart`); repositorios usam `try/catch` interno e retornam `ResultStatus.error(mensagemErroRepositorio(...))`.
- `CacheManager` via DI (GetIt); nao usar singleton global.
- Drift: tabela `XxxRecords`, linha `XxxRecord`, DAO `XxxDao`; nao usar `@UseRowClass` com entidades de `lib/core/models/`.
- Codigo em ingles; documentacao e comentarios `///` em portugues.
- Commit: `<tipo>: <descricao concisa>` com tipos `feat`, `fix`, `docs`, `style`, `refactor`, `test`; mensagem em portugues.

## Pitfalls
- O projeto esta em desenvolvimento: nao ha obrigacao de compatibilidade retroativa de JSON/modelos/schemas.
- Ha legado em `lib/core/managers/`; priorizar migracao para arquitetura limpa sem quebrar fluxo atual sem validacao.
- Web Drift exige `web/sqlite3.wasm` e `web/drift_worker.js`.
- Existem testes com falhas pre-existentes; validar primeiro o escopo alterado.

## Referencias (link, nao duplicar)
- Guia de contribuicao: `CONTRIBUTING.md`
- Visao geral e comandos: `README.md`
- Instrucoes Dart por arquivo: `.github/instructions/dartcode.instructions.md`
- Effective Dart + Flutter: `.github/instructions/dart-n-flutter.instructions.md`
- Arquitetura e migracao Drift: `docs/DRIFT_ARCHITECTURE.md`, `docs/DRIFT_MIGRATION.md`
- Guia de testes: `README_TESTING.md`, `docs/TESTING_VALIDATION.md`