# Interface Architecture

## Contents

- [Overview](#overview)
- [Layer Flow](#layer-flow)
- [Main Interfaces](#main-interfaces)
- [Return and Error Standards](#return-and-error-standards)
- [GetIt Registration](#getit-registration)
- [Best Practices](#best-practices)
- [References](#references)

## Overview

Interfaces in `lib/core/interface/` define contracts between the presentation layer and repositories/services.
Concrete implementations are kept outside the UI and resolved through dependency injection.

## Layer Flow

Screen (BLoC/Cubit) -> Interface (`lib/core/interface/`) -> Repository (`lib/domain/repository/`) -> DAO Drift (`lib/data/database/dao/`) -> SQLite.

## Main Interfaces

- `ICustomerRepository`
- `ICompanyRepository`
- `IProductRepository`
- `ISalesRepository`
- `ICategoryRepository`
- `IConfigurationRepository`
- `ILogRepository`
- `IUserRepository`
- `ISystemRepository`
- `IAnalyticsRepository`

In addition to repositories, `lib/core/interface/` also defines contracts for shared services:

- `ISettingsService` - application theme settings (primary color, light/dark mode).
- `ISystemErrorManager` - querying and clearing cached system errors.

Interfaces remain in `lib/core/interface/`, and their implementations are in `lib/domain/repository/`.

## Return and Error Standards

- Repository operations return `ResultStatus<R, E>`.
- Repositories catch exceptions internally and return `ResultStatus.error(...)` with a user-friendly message.
- The presentation layer must not wrap repository calls in `try/catch`; it should handle `ResultStatus` with `when`/`switch`.

Brief example:

```dart
final result = await repository.getAllCustomers();
result.when(
  onSuccess: (customers) => emit(CustomerLoaded(customers)),
  onError: (message) => emit(CustomerError(message)),
);
```

## GetIt Registration

Dependencies are registered in `setupAppInjection()` in `lib/application/app_injection.dart`.

Example:

```dart
appInjection.registerSingleton<ICustomerRepository>(
  CustomerRepository(
    logRepository: appInjection.get<ILogRepository>(),
    customerDao: appInjection.get<AppDatabase>().customerDao,
  ),
);
```

## Best Practices

- Keep interface contracts concise and use-case oriented.
- Avoid leaking persistence details (DAO, Companion, SQL) to higher layers.
- Keep naming consistent between the interface and its implementation.
- Prefer asynchronous methods for I/O operations.
- Avoid extending legacy flows based on JSON managers in new workflows.

## References

- `README.md`
- `.github/copilot-instructions.md`
- `documentation/DRIFT_ARCHITECTURE.md`
- `lib/application/app_injection.dart`
