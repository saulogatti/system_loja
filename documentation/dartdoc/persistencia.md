# Drift Persistence

`AppDatabase` (store) and `SystemDatabase` (users, logs, settings). Convention: table `XxxRecords`, row `XxxRecord`, DAO `XxxDao`. Map to the domain with extensions/mappers — do not use `@UseRowClass` with entities in `lib/core/`.

Guides: [Drift Architecture](../DRIFT_ARCHITECTURE.md) and [Drift Migration](../DRIFT_MIGRATION.md).
