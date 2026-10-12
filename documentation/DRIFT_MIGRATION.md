# Drift Migration

## Overview

This document consolidates guidance for Drift schema migrations in System Loja.

## Current Database State

- `AppDatabase`: `schemaVersion => 12`
- `SystemDatabase`: `schemaVersion => 1`

## When to Create a Migration

Create or update a migration whenever any of the following change:

- Drift tables (`lib/data/database/table/`)
- DAOs (`lib/data/database/dao/`)
- Relationships/constraints
- Types persisted through a converter/custom type

## Recommended Process

1. Update the relevant table(s) and/or DAO(s).
1. Increment `schemaVersion` in the correct database.
1. Implement `onUpgrade` with the required migration steps.
1. Generate code:

```bash
dart run build_runner build
```

1. Validate quality:

```bash
dart analyze
flutter test
```

## Best Practices

- Keep migrations small and incremental.
- Avoid business logic in the migration layer.
- Preserve data when applicable; before production, breaking changes are acceptable when agreed upon by the team.
- Record in the PR which schema versions changed and why.

## Troubleshooting

### build_runner Failure

```bash
dart run build_runner clean
dart run build_runner build
```

### Local Schema Conflict

- Remove the local app installation to create a clean database when appropriate.
- Confirm that `onUpgrade` covers every step between versions.

## References

- `README.md`
- `documentation/DRIFT_ARCHITECTURE.md`
- `.github/copilot-instructions.md`
