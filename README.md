# System Loja

Aplicativo Flutter multiplataforma para gerenciamento de loja (clientes, produtos, categorias, empresa e notas/vendas), com persistencia local em SQLite via Drift e fluxo legado em JSON ainda ativo em partes especificas.

## Visao geral

- UI em `lib/screens/`, com BLoC/Cubit (`flutter_bloc`).
- Fluxo principal: Screen -> Interface -> Repository -> DAO Drift -> SQLite.
- DI com `GetIt` via `setupAppInjection()`.
- Navegacao com `auto_route` em `lib/screens/route/route_app.dart`.
- Padrao de retorno entre camadas: `ResultStatus<R, E>`.

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

- `AppDatabase` (`lib/data/database/app_database.dart`) com `schemaVersion => 11`.
- `SystemDatabase` (`lib/data/database/system_database.dart`) com `schemaVersion => 1`.

### Legado JSON

Ha codigo legado em `lib/core/managers/` e no diretorio `data/` ainda utilizado em cenarios pontuais. Nao remover esse fluxo sem validar impacto funcional.

### Convencoes importantes

- Nao propagar excecoes entre Interface/Repository; retornar `ResultStatus`.
- Drift segue padrao: tabela `XxxRecords`, linha `XxxRecord`, DAO `XxxDao`.
- Codigo em ingles; documentacao e comentarios (`///`) em portugues.

## Estrutura resumida

```text
lib/
  app_injection.dart
  core/
    interface/
    repository/
    managers/           # legado em uso pontual
    models/
    utils/
  data/
    database/
      dao/
      table/
      extension/
  screens/
    route/
test/
docs/
```

## Observacoes importantes

- No Web, Drift depende de `web/sqlite3.wasm` e `web/drift_worker.js`.
- Existem testes com falhas pre-existentes no repositorio; valide primeiro o escopo alterado antes de tratar falhas fora da tarefa.

## Documentacao principal

- `CONTRIBUTING.md`
- `.github/copilot-instructions.md`
- `.github/instructions/dartcode.instructions.md`
- `AGENTS.md`
- `docs/DRIFT_ARCHITECTURE.md`
- `docs/DRIFT_MIGRATION.md`
- `docs/VALIDATION_SYSTEM.md`
