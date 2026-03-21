---
description: Instrucoes praticas para implementacoes e correcoes no System Loja
applyTo: "**"
---

# Instrucoes para Agentes de Implementacao - System Loja

Este arquivo define o comportamento esperado para implementacoes, correcoes e refatoracoes no projeto.

## 1) Arquitetura e fluxo

- UI em `lib/screens/`.
- Fluxo principal: Screen (Bloc/Cubit) -> Interface (`lib/core/interface/`) -> Repository (`lib/core/repository/`) -> DAO Drift (`lib/data/database/dao/`) -> SQLite.
- DI com `GetIt` via `setupAppInjection()`.
- Navegacao com `auto_route` em `lib/screens/route/route_app.dart`.

## 2) Persistencia

- Banco principal: `AppDatabase` com `schemaVersion => 11`.
- Banco de sistema: `SystemDatabase` com `schemaVersion => 1`.
- Existe legado JSON em `lib/core/managers/` e em `data/` ainda usado em partes do sistema.

Regras:

- Nao remover fluxo legado sem validar impacto.
- Em mudanca de schema Drift, atualizar `schemaVersion` e estrategia de migracao no banco correto.

## 3) Tratamento de erros e contratos

- O padrao oficial de retorno e `ResultStatus<R, E>` (`lib/core/utils/command_result.dart`).
- Nao introduzir `OperationResult`, `Either` ou contratos alternativos sem alinhamento previo.
- Nao propagar excecoes entre Interface e Repository; retornar `ResultStatus`.

## 4) Convencoes de codigo

- Drift:
  - tabela: `XxxRecords`
  - linha: `XxxRecord`
  - DAO: `XxxDao`
- Reutilizar `@UseRowClass(...)` quando aplicavel para reduzir mapeamento manual.
- Codigo em ingles.
- Documentacao e comentarios (`///`) em portugues.

## 5) Build, codegen e validacao

Sempre executar quando aplicavel:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart analyze
flutter test
```

Quando rodar build_runner:

- Alteracoes em `@freezed`
- Alteracoes em `@JsonSerializable`
- Alteracoes em Drift (`@DriftDatabase`, `@DriftAccessor`, tabelas e DAOs)
- Alteracoes em rotas (`@RoutePage` / AutoRoute)

## 6) Web e multiplataforma

- Para Drift no Web funcionar, manter `web/sqlite3.wasm` e `web/drift_worker.js`.
- Evitar solucao especifica de SO sem fallback para Windows/Linux/Web.

## 7) Checklist antes de concluir

- [ ] Implementacao segue fluxo de camadas (Screen -> Interface -> Repository -> DAO).
- [ ] Contratos retornam `ResultStatus<R, E>`.
- [ ] Mudancas de schema incluem migracao e versao.
- [ ] Build runner executado quando necessario.
- [ ] `dart analyze` sem novos erros causados pela alteracao.
- [ ] Testes de escopo executados.
- [ ] Comentarios e docs no padrao do projeto.
