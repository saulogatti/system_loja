---
description: Instrucoes praticas para implementacoes e correcoes no System Loja
applyTo: "**"
---

# Instrucoes para Agentes de Implementacao - System Loja

Este arquivo define o comportamento esperado para implementacoes, correcoes e refatoracoes no projeto.

## 1) Arquitetura e fluxo

- UI em `lib/screens/`.
- Fluxo principal: Screen (Bloc/Cubit) -> Interface (`lib/core/interface/`) -> Repository (`lib/domain/repository/`) -> DAO Drift (`lib/data/database/dao/`) -> SQLite.
- **Arquitetura limpa e obrigatoria**: manter dominio (`lib/core/`) sem dependencias desnecessarias da camada de dados; DTOs, JSON e Drift em `lib/data/`; implementacoes de repositorio em `lib/domain/`. Refactors grandes sao aceitaveis para preservar essas fronteiras (detalhes em `.github/copilot-instructions.md`).
- DI com `GetIt` via `setupAppInjection()`.
- Navegacao com `auto_route` em `lib/screens/route/route_app.dart`.

## 2) Persistencia e compatibilidade

- Banco principal: `AppDatabase` com `schemaVersion => 12`.
- Banco de sistema: `SystemDatabase` com `schemaVersion => 1`.
- Existe codigo legado em `lib/core/managers/` e JSON em partes do sistema; a direcao preferida e refatorar em direcao a arquitetura limpa, nao congelar formato antigo.

Regras:

- **Compatibilidade retroativa nao e requisito** enquanto o app esta em desenvolvimento: pode-se alterar contratos JSON, modelos e schemas quando a arquitetura exigir; atualizar `build_runner`, Drift e testes do escopo.
- Em mudanca de schema Drift, atualizar `schemaVersion` e estrategia de migracao no banco correto.

## 3) Tratamento de erros e contratos

- O padrao oficial de retorno e `ResultStatus<R, E>` (`lib/core/utils/result_status.dart`, usa `package:meta`).
- Nao introduzir `OperationResult`, `Either` ou contratos alternativos sem alinhamento previo.
- Nao propagar excecoes entre Interface e Repository; retornar `ResultStatus`. Repositorios usam `try/catch` internamente e retornam `ResultStatus.error(mensagemErroRepositorio(erro, contexto: '...'))` com mensagens amigaveis (ver `lib/core/utils/repository_error_mapper.dart`).
- A camada de apresentacao (BLoC/Cubit/Screen) **nao** envolve chamadas ao repositorio em `try/catch`; usa `when` ou `switch` no `ResultStatus`. `try/catch` na UI fica reservado a operacoes locais (seletor de arquivo, escrita em `File`) que nao passam pelo contrato do repositorio.

## 4) Convencoes de codigo

- Drift:
  - tabela: `XxxRecords`
  - linha: `XxxRecord`
  - DAO: `XxxDao`
- **Nao** usar `@UseRowClass` apontando para entidades de `lib/core/models/`; mapear `XxxRecord` -> dominio em `lib/data/database/mapper/` ou no DAO/repositorio.
- `SystemDatabase` aceita `QueryExecutor` opcional no construtor para testes com banco em memoria.
- `CacheManager` registrado via `GetIt` (DI); nao usar `CacheManager.instance`. Repositorios o recebem por injecao de construtor.
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
