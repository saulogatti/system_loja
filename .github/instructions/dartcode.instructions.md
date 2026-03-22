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
- Fluxo de camadas: Screen -> Interface (`lib/core/interface/`) -> Repository (`lib/domain/repository/`) -> DAO Drift (`lib/data/database/dao/`).
- `lib/data/` nao deve importar `lib/domain/` nem `lib/aplication/`.
- Nao propagar excecoes entre Interface e Repository. Repositorios usam `try/catch` internamente e retornam `ResultStatus.error(mensagemErroRepositorio(...))` com mensagens amigaveis (`lib/core/utils/repository_error_mapper.dart`). A camada de apresentacao nao usa `try/catch` para chamadas ao repositorio.
- Retornar `ResultStatus<R, E>` (`lib/core/utils/command_result.dart`, usa `package:meta`).
- `CacheManager` registrado via `GetIt` (DI); nao usar `CacheManager.instance`.

## Drift

- Tabela: `XxxRecords`
- Linha: `XxxRecord` (gerada)
- DAO: `XxxDao`
- Nao acoplar tabelas a modelos de `lib/core/` via `@UseRowClass`; mapear registro -> dominio em mapper/DAO/repository.
- Em alteracao de schema, atualizar `schemaVersion` / migracao no banco correto (pre-producao: breaking changes aceitos).

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
