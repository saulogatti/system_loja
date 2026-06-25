# System Loja - Copilot Instructions

Use estas instrucoes como complemento rapido ao `README.md`, `CONTRIBUTING.md`, `README_TESTING.md`, `AGENTS.md` e aos arquivos em `.github/instructions/`. Olhar os detalhes de `styleguide.md` que tem algumas regras e convencoes importantes para o projeto. Se tiver duvidas, consulte os arquivos de documentacao ou pergunte a um humano.

## Build, test and lint

- Instalar dependencias: `flutter pub get`
- Rodar o app:
  - Windows: `flutter run -d windows`
  - Linux: `flutter run -d linux`
  - Chrome: `flutter run -d chrome`
  - Web server: `flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0`
- Rodar `dart run build_runner build --delete-conflicting-outputs` após fazer alteracao em classes que tenham annotations: `@freezed`, `@JsonSerializable`, Drift (`@DriftDatabase`, `@DriftAccessor`, tabelas/DAOs) ou `auto_route`.
- Se houver conflito com arquivos gerados, executar: `dart run build_runner clean` e depois `dart run build_runner build --delete-conflicting-outputs`.
- Analise estatica: `dart analyze`
- Verificacao de formatacao: `dart format --set-exit-if-changed .`
- Suite completa de testes: `flutter test`
- Um arquivo de teste: `flutter test test/<arquivo>_test.dart`
- Um teste especifico por nome: `flutter test test/<arquivo>_test.dart --plain-name "nome do teste"`
- Testes por area, quando ajudar na iteracao: `flutter test test/screens/` ou `flutter test test/core/`
- Se houver falhas legadas fora do escopo, validar primeiro os testes do escopo alterado antes da suite completa.

## High-level architecture

- O app sobe em `lib/main.dart`: chama `setupAppInjection()`, registra dependencias no `GetIt` e monta um `MaterialApp.router` com `RouteApp`.
- `setupAppInjection()` em `lib/aplication/app_injection.dart` e o ponto central de wiring: registra bancos Drift, repositories, services, cache, router e o carregamento inicial de configuracoes via `IConfigurationRepository`.
- A UI fica em `lib/screens/` e usa `flutter_bloc` com BLoCs/Cubits injetados no topo do app. A navegacao e declarada em `lib/screens/route/route_app.dart` com `auto_route` e nested routes sob `HostRoute`.
- O fluxo principal do projeto e: **Screen/BLoC/Cubit -> interfaces em `lib/core/interface/` -> repositories em `lib/domain/repository/` -> DAOs Drift em `lib/data/database/dao/` -> SQLite**.
- A persistencia e dividida em dois bancos:
  - `AppDatabase` (`lib/data/database/app_database.dart`): dados de negocio como clientes, produtos, categorias, empresa, notas e itens.
  - `SystemDatabase` (`lib/data/database/system_database.dart`): usuarios, logs e configuracoes de sistema.
- `lib/data/` concentra persistencia e adaptacao: tabelas Drift, DAOs, `entry/` para DTOs serializaveis, `converter/`, `cache/` e `mapper/` para transformar `XxxRecord` em modelos de `lib/core/models/`.
- Ha codigo legado em `lib/core/managers/` e alguns fluxos JSON antigos. O caminho preferencial para novas features e manter o fluxo atual baseado em Drift + repository.

## Key conventions

- Codigo em ingles; comentarios e documentacao `///` em portugues.
- A UI nao deve chamar DAOs diretamente nem depender de implementacoes concretas de repository; ela consome interfaces de `lib/core/interface/`.
- Operacoes de repository retornam `ResultStatus<R, E>` (`lib/core/utils/command_result.dart`). Repositories capturam excecoes internamente e retornam `ResultStatus.error(...)`; a camada de apresentacao trata o resultado com `when` ou `switch`, sem `try/catch` em chamadas de repository.
- `try/catch` na UI fica restrito a operacoes locais que nao passam por repository, como seletores de arquivo ou I/O direto.
- `lib/data/` nao deve importar `lib/domain/` nem `lib/aplication/`; mantenha detalhes de persistencia abaixo das interfaces e repositories.
- Drift segue a convencao: tabela `XxxRecords`, linha gerada `XxxRecord`, DAO `XxxDao`. Nao use `@UseRowClass` com entidades de `lib/core/models/`; faca o mapeamento em `mapper/`, `extension/`, DAO ou repository.
- See `docs/DRIFT_ARCHITECTURE.md` for the step-by-step migration pattern. At minimum, add a `from-to` step in `MigrationStrategy.onUpgrade` and a corresponding schema snapshot under `drift_schemas/`.
- `CacheManager` e outros servicos compartilhados entram por DI (`GetIt`); nao introduza singletons globais paralelos.
- Em testes de VM que instanciam `AppDatabase`, reutilize os helpers de `test/support/test_app_database.dart` para evitar dependencia de `path_provider`.
- No Web, Drift depende de `web/sqlite3.wasm` e `web/drift_worker.js`; nao remova esses arquivos ao mexer em build web.
- Commits seguem o formato `<tipo>: <descricao concisa>` com tipos como `feat`, `fix`, `docs`, `refactor` e `test`, em portugues.

## MCP servers

- Para fluxos web (`flutter run -d chrome` ou `flutter run -d web-server`), prefira usar um MCP do Playwright quando estiver disponivel para validar navegacao, estados de UI, formularios e regressao visual.
- Use o MCP para validar comportamento de tela no navegador; continue usando `flutter test` para cobertura automatizada do repositorio.

## References

- `README.md`
- `CONTRIBUTING.md`
- `README_TESTING.md`
- `AGENTS.md`
- `.github/instructions/dartcode.instructions.md`
- `.github/instructions/dart-n-flutter.instructions.md`
- `docs/BUILD_INSTRUCTIONS.md`
- `docs/DRIFT_ARCHITECTURE.md`
- `docs/INTERFACES_ARCHITECTURE.md`
