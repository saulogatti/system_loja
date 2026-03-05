# System Loja

Aplicativo Flutter multiplataforma para gerenciamento de loja (clientes, produtos, vendas/notas, empresa, categorias e configuracoes), com persistencia principal em SQLite via Drift.

## Visao Geral

- UI em `lib/screens/` com `flutter_bloc` (BLoC/Cubit)
- Fluxo principal: Screen -> Interface -> Repository -> DAO Drift -> SQLite
- Navegacao com `auto_route`
- Injecao de dependencia com `GetIt` em `setupAppInjection()`
- Resultado de operacoes com `ResultStatus<R, E>` (`lib/core/utils/command_result.dart`)

## Requisitos

- Flutter 3.41.2 ou superior
- Dart >= 3.11.0 (`pubspec.yaml`)

## Setup Rapido

```bash
git clone https://github.com/saulogatti/system_loja.git
cd system_loja
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

## Executar

```bash
# Windows
flutter run -d windows

# Linux
flutter run -d linux

# Web (chrome)
flutter run -d chrome

# Web (servidor local)
flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0
```

## Comandos Uteis

```bash
# Gerar codigo (obrigatorio quando alterar Freezed/JsonSerializable/Drift/AutoRoute)
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

- `AppDatabase` em `lib/data/database/app_database.dart` (schemaVersion `11`)
- `SystemDatabase` em `lib/data/database/system_database.dart` (schemaVersion `2`)

### Persistencia Legacy

Parte do projeto ainda utiliza JSON e codigo legado em `lib/core/managers/` e `data/`. Nao remover esse fluxo sem validar impacto.

### Convencoes Importantes

- Usar `ResultStatus<R, E>` para retorno de operacoes, sem propagar excecoes entre camadas.
- Em Drift, seguir convencao: tabela `XxxRecords`, linha `XxxRecord`, DAO `XxxDao`.
- Codigo em ingles; documentacao e comentarios (`///`) em portugues.

## Estrutura (Resumo)

```text
lib/
  app_injection.dart
  core/
    interface/
    repository/
    managers/           # legado ainda em uso pontual
    models/
    utils/
  data/
    database/
      dao/
      table/
      extension/
  screens/
    route/
    widgets/
test/
docs/
```

## Observacoes Web

Para Drift no Web funcionar, os arquivos `web/sqlite3.wasm` e `web/drift_worker.js` devem estar presentes.

## Contribuicao

- Leia `CONTRIBUTING.md`
- Para agentes/copilot, consulte `.github/copilot-instructions.md` e `AGENTS.md`
- Sempre rode build_runner quando alterar anotacoes de geracao

## Documentacao

- `CONTRIBUTING.md`
- `.github/copilot-instructions.md`
- `.github/instructions/dartcode.instructions.md`
- `docs/DRIFT_ARCHITECTURE.md`
- `docs/DRIFT_MIGRATION.md`
- `docs/VALIDATION_SYSTEM.md`
- `docs/`
