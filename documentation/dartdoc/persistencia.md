# Persistência Drift

`AppDatabase` (loja) e `SystemDatabase` (usuários, logs, configuração). Convenção: tabela `XxxRecords`, linha `XxxRecord`, DAO `XxxDao`. Mapeamento para domínio em extensões/mappers — sem `@UseRowClass` nas entidades de `lib/core/`.

Guias: [Arquitetura Drift](../DRIFT_ARCHITECTURE.md) e [Migração Drift](../DRIFT_MIGRATION.md).
