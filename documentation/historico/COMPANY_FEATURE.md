# Feature: Company Registration

## Overview

This feature covers company creation, listing, CNPJ lookup, updating, and deletion, following the project's standard flow:

Screen -> Interface -> Repository -> DAO Drift -> SQLite.

## Business Rules

- CNPJ values must be unique in the database.
- CNPJ values are normalized for comparison/storage (digits only).
- Repository operations return `ResultStatus<R, E>` with user-friendly messages.

## Current Architecture

### Domain/Core

- Model: `lib/core/models/company.dart`
- Interface: `lib/core/interface/i_company_repository.dart`

### Data (Drift)

- Table: `lib/data/database/table/company_records.dart`
- DAO: `lib/data/database/dao/company_dao.dart`
- Conversion to companion: `lib/data/database/extension/company_to_companion.dart`

### Repository

- Implementation: `lib/domain/repository/company_repository.dart`
- DI registration: `setupAppInjection()` in `lib/application/app_injection.dart`

### Presentation

- Main screen: `lib/screens/company/company_view.dart`
- BLoC and states: `lib/screens/company/bloc/`
- Widgets: `lib/screens/company/widgets/`

## Database

- Primary database: `AppDatabase`
- Current schema version: `12`
- The company table is registered in `AppDatabase`'s `@DriftDatabase`.

## Code Generation and Validation

Whenever Freezed/JSON models, Drift DAOs/tables, or routes change:

```bash
dart run build_runner build
dart analyze
flutter test
```

## Functional Test Checklist

1. Register a company with a valid CNPJ.
2. Try to register a duplicate CNPJ (a user-friendly error should be returned).
3. Search for companies using an existing and a nonexistent CNPJ.
4. Edit company data and confirm that the changes persist.
5. Delete a company and verify that the list is updated.

## Historical Note

Older versions of this document referred to previous paths and schema versions (e.g., repositories in `lib/core/repository/` and schema `9`). The current project uses repositories in `lib/domain/repository/` and schema `12` in `AppDatabase`.
