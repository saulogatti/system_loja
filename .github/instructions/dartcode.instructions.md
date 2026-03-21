---
description: Regras para codigo Dart no System Loja (arquitetura, ResultStatus e Drift)
applyTo: '**/*.dart'
---

# Regras de codigo Dart

## Diretrizes gerais

- Seguir Effective Dart.
- Usar `dart format`.
- Priorizar legibilidade e simplicidade.
- Evitar alteracoes fora do escopo da tarefa.

## Convencoes do projeto

- Codigo em ingles.
- Comentarios e documentacao `///` em portugues.
- Fluxo de camadas: Screen -> Interface -> Repository -> DAO Drift.
- Nao propagar excecoes entre Interface e Repository.
- Retornar `ResultStatus<R, E>` (`lib/core/utils/command_result.dart`).

## Drift

- Tabela: `XxxRecords`
- Linha: `XxxRecord`
- DAO: `XxxDao`
- Preferir `@UseRowClass(...)` quando aplicavel.
- Em alteracao de schema, atualizar migracao e `schemaVersion` no banco correto.

## Geracao de codigo

Executar `dart run build_runner build --delete-conflicting-outputs` ao alterar:

- classes com `@freezed`
- classes com `@JsonSerializable`
- tabelas/DAOs Drift
- rotas do AutoRoute

## Qualidade

Antes de concluir alteracoes Dart, validar:

```bash
dart analyze
flutter test
```
