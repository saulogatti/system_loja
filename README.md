# System Loja

Aplicativo Flutter multiplataforma para gerenciamento de loja (clientes, produtos, categorias, empresa e notas/vendas), com persistencia local em SQLite via Drift e fluxo legado em JSON ainda ativo em partes especificas.

## Visao geral

- UI em `lib/screens/`, com BLoC/Cubit (`flutter_bloc`).
- Fluxo principal: **Screen** → **Interface** (`lib/core/interface/`) → **Repository** (`lib/domain/repository/`) → **DAO Drift** (`lib/data/database/dao/`) → SQLite.
- DI com `GetIt` via `setupAppInjection()` em `lib/application/app_injection.dart`.
- Navegacao com `auto_route` em `lib/screens/route/route_app.dart`.
- Padrao de retorno entre camadas: `ResultStatus<R, E>` (`lib/core/utils/result_status.dart`, usa `package:meta`).
- Repositorios usam `try/catch` internamente e retornam `ResultStatus.error(...)` com mensagens amigaveis via `mensagemErroRepositorio()` (`lib/core/utils/repository_error_mapper.dart`). A camada de apresentacao **nao** envolve chamadas ao repositorio em `try/catch`; usa `when` ou `switch` em `ResultStatus`.
- Camada **data** (`lib/data/`): Drift, DTOs/entries JSON, conversores, cache e mapeamento para modelos de `lib/core/models/` — **sem** depender de `lib/domain/` ou `lib/application/` (constantes compartilhadas ficam em `lib/core/` quando necessario).
- `CacheManager` registrado via `GetIt` (injecao de dependencia) — **nao** usar `CacheManager.instance`.

## Requisitos

- Flutter 3.41.2 ou superior.
- Dart SDK `>=3.11.0`.

## Setup rapido

```bash
git clone https://github.com/saulogatti/system_loja.git
cd system_loja
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

## Executar o app

```bash
# Windows
flutter run -d windows

# Linux
flutter run -d linux

# Web (Chrome)
flutter run -d chrome

# Web (servidor local)
flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0
```

## Comandos de qualidade

```bash
# Codegen (obrigatorio apos alterar Freezed/JsonSerializable/Drift/AutoRoute)
dart run build_runner build --delete-conflicting-outputs

# Analise estatica
dart analyze

# Formatacao
dart format --set-exit-if-changed .

# Testes
flutter test
flutter test test/<arquivo>_test.dart
```

## Arquitetura

### Bancos Drift

- `AppDatabase` (`lib/data/database/app_database.dart`) com `schemaVersion => 12`.
- `SystemDatabase` (`lib/data/database/system_database.dart`) com `schemaVersion => 1`.

### Legado JSON

Ha codigo legado em `lib/core/managers/` e fluxos em JSON ainda usados em cenarios pontuais. Nao remover sem validar impacto; o fluxo principal da loja e **SQLite via Drift**. Os arquivos de dados estaticos anteriores (`data/*.json`) foram removidos.

### Convencoes importantes

- Nao propagar excecoes entre Interface/Repository; retornar `ResultStatus`. Repositorios capturam excecoes internamente (`try/catch`) e devolvem `ResultStatus.error(mensagemErroRepositorio(...))`. A camada de apresentacao nao usa `try/catch` para chamadas ao repositorio.
- Drift: tabela `XxxRecords`, linha gerada `XxxRecord`, DAO `XxxDao`. Linhas Drift **nao** usam `@UseRowClass` com entidades de `lib/core/`; o mapeamento para dominio fica em extensoes/helpers (ex.: `lib/data/database/mapper/`) ou nos DAOs/repositorios, conforme o padrao do projeto.
- DTOs serializaveis (JSON) em `lib/data/entry/` e afins; modelos de negocio em `lib/core/models/`.
- Codigo em ingles; documentacao e comentarios (`///`) em portugues.
- `SystemDatabase` aceita `QueryExecutor` opcional no construtor para facilitar testes com banco em memoria.

## Estrutura resumida

```text
lib/
  main.dart
  application/
    app_injection.dart   # GetIt / setupAppInjection()
  core/
    interface/           # contratos (ex.: I*Repository)
    constants/
    managers/            # legado em uso pontual
    models/              # entidades de dominio
    utils/               # ResultStatus, repository_error_mapper, extensoes
  domain/
    repository/          # implementacoes dos repositorios
    *.dart               # servicos de dominio (ex.: geracao de codigo)
  data/
    database/
      dao/
      table/
      extension/
      mapper/            # XxxRecord -> modelo de dominio
    entry/               # DTOs JSON (json_serializable)
    cache/
    converter/
    models/              # modelos de persistencia auxiliares
  screens/
    route/
test/
  support/               # helpers (ex.: AppDatabase em teste sem path_provider)
docs/
```

## Observacoes importantes

- No Web, Drift depende de `web/sqlite3.wasm` e `web/drift_worker.js`.
- Existem testes com falhas pre-existentes no repositorio; valide primeiro o escopo alterado antes de tratar falhas fora da tarefa.
- Testes que instanciam `AppDatabase` na VM podem usar `applicationSupportDirectory` e `tempDirectoryPath` (ver `test/support/test_app_database.dart`) para evitar `path_provider` / `MissingPluginException`.

## Documentacao principal

- `CONTRIBUTING.md`
- `.github/copilot-instructions.md`
- `.github/instructions/dartcode.instructions.md`
- `AGENTS.md`
- `docs/BUILD_INSTRUCTIONS.md`
- `docs/DRIFT_ARCHITECTURE.md`
- `docs/DRIFT_MIGRATION.md`
- `docs/INTERFACES_ARCHITECTURE.md`
- `docs/VALIDATION_SYSTEM.md`
