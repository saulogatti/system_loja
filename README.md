# System Loja

Aplicativo Flutter multiplataforma para gerenciamento de loja (clientes, produtos, categorias, empresa e notas/vendas), com persistência local em SQLite via Drift.

## Visão geral

- UI em `lib/screens/`, com BLoC/Cubit (`flutter_bloc`).
- Fluxo principal: **Screen** → **Interface** (`lib/core/interface/`) → **Repository** (`lib/domain/repository/`) → **DAO Drift** (`lib/data/database/dao/`) → SQLite.
- DI com `GetIt` via `setupAppInjection()` em `lib/application/app_injection.dart` — resolver com `appInjection.get<T>()`.
- Navegação com `auto_route` em `lib/screens/route/route_app.dart`.
- Padrão de retorno entre camadas: `ResultStatus<R, E>` (`lib/core/utils/result_status.dart`, usa `package:meta`).
- Repositórios usam `try/catch` internamente e retornam `ResultStatus.error(...)` com mensagens amigáveis via `mensagemErroRepositorio()` (`lib/core/utils/repository_error_mapper.dart`). A camada de apresentação **não** envolve chamadas ao repositório em `try/catch`; usa `when` ou `switch` em `ResultStatus`.
- Camada **data** (`lib/data/`): Drift, DTOs/entries JSON, conversões, cache e mapeamento para modelos de `lib/core/models/` — **sem** depender de `lib/domain/` ou `lib/application/` (constantes compartilhadas ficam em `lib/core/` quando necessário).
- `CacheManager` registrado via `GetIt` (injeção de dependência) — **não** usar `CacheManager.instance`.

## Requisitos

- Flutter `>=3.47.0` (conforme `pubspec.yaml`).
- Dart SDK `>=3.13.0 <4.0.0`.

## Setup rápido

```bash
git clone https://github.com/saulogatti/system_loja.git
cd system_loja
flutter pub get
dart run build_runner build
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
# Codegen (obrigatório após alterar Freezed/JsonSerializable/Drift/AutoRoute)
dart run build_runner build

# Análise estática
dart analyze

# Formatação
dart format --set-exit-if-changed .

# Testes
flutter test
flutter test test/<arquivo>_test.dart
```

## Arquitetura

### Bancos Drift

- `AppDatabase` (`lib/data/database/app_database.dart`) com `schemaVersion => 12`.
- `SystemDatabase` (`lib/data/database/system_database.dart`) com `schemaVersion => 1`.

### Persistência e DTOs

A persistência principal da loja é **SQLite via Drift**. DTOs serializáveis (JSON) ficam em `lib/data/entry/` e afins quando necessário para importação/exportação ou serialização pontual — **não** há pasta `lib/core/managers/` nem managers JSON como padrão de feature nova.

### Convenções importantes

- Não propagar exceções entre Interface/Repository; retornar `ResultStatus`. Repositórios capturam exceções internamente (`try/catch`) e devolvem `ResultStatus.error(mensagemErroRepositorio(...))`. A camada de apresentação não usa `try/catch` para chamadas ao repositório.
- Drift: tabela `XxxRecords`, linha gerada `XxxRecord`, DAO `XxxDao`. Linhas Drift **não** usam `@UseRowClass` com entidades de `lib/core/`; o mapeamento para domínio fica em extensões/helpers (ex.: `lib/data/database/mapper/`) ou nos DAOs/repositórios, conforme o padrão do projeto.
- Modelos de negócio em `lib/core/models/`.
- Código em inglês; documentação e comentários (`///`) em português.
- `SystemDatabase` aceita `QueryExecutor` opcional no construtor para facilitar testes com banco em memória.
- Navegação de páginas com `auto_route`; `Navigator` apenas para dialogs/bottom sheets/modais.

## Estrutura resumida

```text
lib/
  main.dart
  application/
    app_injection.dart   # GetIt / setupAppInjection()
  core/
    interface/           # contratos (ex.: I*Repository)
    constants/
    models/              # entidades de domínio
    services/            # serviços transversais (quando aplicável)
    utils/               # ResultStatus, repository_error_mapper, extensões
  domain/
    repository/          # implementações dos repositórios
    *.dart               # serviços de domínio (ex.: geração de código)
  data/
    database/
      dao/
      table/
      extension/
      mapper/            # XxxRecord -> modelo de domínio
    entry/               # DTOs JSON (json_serializable)
    cache/
    converter/
    models/              # modelos de persistência auxiliares
  screens/
    route/
test/
  support/               # helpers (ex.: AppDatabase em teste sem path_provider)
docs/
  historico/             # material antigo (não usar como padrão)
```

## Observações importantes

- No Web, Drift depende de `web/sqlite3.wasm` e `web/drift_worker.js`.
- Existem testes com falhas pré-existentes no repositório; valide primeiro o escopo alterado antes de tratar falhas fora da tarefa.
- Testes que instanciam `AppDatabase` na VM podem usar `applicationSupportDirectory` e `tempDirectoryPath` (ver `test/support/test_app_database.dart`) para evitar `path_provider` / `MissingPluginException`.

## Documentação principal

- `CONTRIBUTING.md`
- `.github/copilot-instructions.md`
- `.github/instructions/dartcode.instructions.md`
- `AGENTS.md`
- `flutter_rules.md` (padrão específico deste repositório)
- `docs/DRIFT_ARCHITECTURE.md`
- `docs/DRIFT_MIGRATION.md`
- `docs/INTERFACES_ARCHITECTURE.md`
- `docs/VALIDATION_SYSTEM.md`
- `docs/CODE_GENERATOR_USAGE.md`
- `docs/TESTING_VALIDATION.md`
- `docs/historico/` — notas e summaries antigos (não canônicos)
