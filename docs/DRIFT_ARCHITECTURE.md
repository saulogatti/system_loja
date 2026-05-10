# Arquitetura Drift no System Loja

## Índice

- [Visão Geral](#visão-geral)
- [Estrutura de Arquivos](#estrutura-de-arquivos)
- [Fluxo de Camadas](#fluxo-de-camadas)
- [Padrões Arquiteturais](#padrões-arquiteturais)
- [Versionamento de Schema](#versionamento-de-schema)
- [Boas Práticas](#boas-práticas)
- [Referências](#referências)

## Visão Geral

O projeto usa Drift como camada principal de persistência local em SQLite.
O fluxo recomendado é: Screen (BLoC/Cubit) -> Interface -> Repository -> DAO Drift -> Banco.

Há dois bancos principais:

- `AppDatabase` para dados de negócio (clientes, produtos, categorias, empresa, notas e itens).
- `SystemDatabase` para dados de sistema (usuários, logs e configurações).

## Estrutura de Arquivos

```text
lib/data/database/
├── app_database.dart              # Banco principal, schema e migrações
├── app_database.g.dart            # Gerado pelo Drift
├── system_database.dart           # Banco de sistema
├── system_database.g.dart         # Gerado pelo Drift
├── dao/                           # DAOs (XxxDao)
├── table/                         # Tabelas Drift (XxxRecords)
│   └── system/                    # Tabelas do banco de sistema
├── extension/                     # Conversões para Companions
└── mapper/                        # Conversões XxxRecord -> domínio
```

## Fluxo de Camadas

```text
Screen (BLoC/Cubit)
  -> Interface (lib/core/interface/)
  -> Repository (lib/domain/repository/)
  -> DAO (lib/data/database/dao/)
  -> Tables/AppDatabase/SystemDatabase
  -> SQLite
```

## Padrões Arquiteturais

### Repository + DAO

- A UI depende de interfaces em `lib/core/interface/`.
- Repositórios em `lib/domain/repository/` coordenam DAOs e regras de negócio.
- DAOs em `lib/data/database/dao/` executam operações de persistência e consultas.
- Transações de múltiplas entidades ficam no repositório, não no DAO.

### Separação de Domínio

- Modelos de domínio em `lib/core/models/` não dependem de Drift.
- Registros gerados (`XxxRecord`) representam o schema físico.
- Conversão entre domínio e persistência é feita por `mapper/` e `extension/`.
- Não usar `@UseRowClass` com entidades de domínio.

### Tratamento de Erros

- Repositórios capturam exceções internamente e retornam `ResultStatus.error(...)`.
- A camada de apresentação não envolve chamadas de repositório em `try/catch`.

## Versionamento de Schema

Estado atual dos bancos:

- `AppDatabase`: `schemaVersion => 12`
- `SystemDatabase`: `schemaVersion => 1`

Ao alterar tabelas, DAOs ou tipos persistidos:

1. Atualize o schema no banco correto.
2. Implemente/ajuste a estratégia de migração.
3. Gere código com `dart run build_runner build --delete-conflicting-outputs`.
4. Valide com `dart analyze` e `flutter test`.

## Boas Práticas

- Mantenha migrações pequenas, explícitas e incrementais.
- Centralize lógica de negócio no repositório.
- Evite expor detalhes de persistência para camadas superiores.
- Use nomes consistentes: tabela `XxxRecords`, linha `XxxRecord`, DAO `XxxDao`.
- Preserve dados quando aplicável; em cenários pré-produção, mudanças incompatíveis podem ser aceitas quando alinhadas com o time.

## Referências

- `README.md`
- `docs/DRIFT_MIGRATION.md`
- `docs/INTERFACES_ARCHITECTURE.md`
- `.github/copilot-instructions.md`
