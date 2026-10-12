<!-- TODO: Verify whether this documentation is outdated -->
# System Loja Domain Services

This directory contains domain services and repository implementations that orchestrate DAOs and business rules.

## Available Services

### CodeGeneratorService

**File**: `code_generator_service.dart`

**Purpose**: Automatic generation and validation of unique product and invoice codes.

**Main Features**:
- Generates product codes in the `PRD-YYYYMMDD-NNNN` format.
- Generates invoice numbers in the `NF-YYYYMMDD-NNNN` format.
- Validates user-provided custom codes.
- Checks the database for duplicates.
- Ensures uniqueness through database checks.

**When to Use**:
- ✅ When creating a product without a predefined code.
- ✅ When creating an invoice without a predefined number.
- ✅ When validating user-provided codes before saving.
- ✅ When checking whether a code already exists in the system.

**How to Use**:

```dart
// Direct access
final codeGenerator = appInjection.get<CodeGeneratorService>();

// Through the repository (recommended)
final productRepository =  appInjection.get<ProductRepository>();
final code = await productRepository.generateProductCode();

final salesRepository = appInjection.get<SalesRepository>();
final invoiceNumber = await salesRepository.generateInvoiceNumber();
```

**Complete documentation**: See `/documentation/CODE_GENERATOR_USAGE.md`.

**Tests**: See `/test/code_generator_service_test.dart`.

---

## Implementation Patterns

### Dependency Injection

Register services and repositories in `setupAppInjection()` (`lib/application/app_injection.dart`) and resolve them with `appInjection.get<T>()`:

```dart
// In lib/application/app_injection.dart (inside setupAppInjection)
appInjection.registerLazySingleton<MeuServicoService>(
  () => MeuServicoService(
    dependencia1: appInjection.get(),
    dependencia2: appInjection.get(),
  ),
);

// Usage
final servico = appInjection.get<MeuServicoService>();
```

### Documentation

All services must:
1. Have `///` comments in English describing their functionality.
2. Document all public methods.
3. Include usage examples when appropriate.
4. Have unit tests covering key scenarios.

### Naming

- Service classes should end with `Service` (e.g., `CodeGeneratorService`).
- Methods should use clear English verbs (e.g., `generateProductCode`, `validateInvoiceNumber`).
- Comments and user-facing strings should be in English.

### Typical Service Structure

```dart
import 'dependencies';

/// Brief service description.
///
/// Detailed description of its features and use cases.
class MeuServicoService {
  final Dependency1 _dependency1;
  final Dependency2 _dependency2;

  MeuServicoService({
    required Dependency1 dependency1,
    required Dependency2 dependency2,
  })  : _dependency1 = dependency1,
        _dependency2 = dependency2;

  /// Method description.
  ///
  /// [param1] Description of the parameter.
  /// Returns a description of the result.
  Future<ReturnType> publicMethod(ParamType param1) async {
    // Implementation
  }

  /// Private helper method.
  TypeReturn _privateHelper(ParamType param) {
    // Implementation
  }
}

/// Helper classes related to the service.
class ServiceResult {
  final bool isSuccess;
  final String message;

  ServiceResult({
    required this.isSuccess,
    required this.message,
  });
}
```

## Tests

Each service should have a corresponding test file in `/test/`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/services/meu_servico_service.dart';

void main() {
  late MeuServicoService service;

  setUp(() {
    // Set up before each test.
    service = MeuServicoService(...);
  });

  tearDown(() {
    // Clean up after each test.
  });

  group('MeuServicoService', () {
    test('should perform a specific action', () async {
      // Arrange.
      final input = ...;

      // Act.
      final result = await service.metodo(input);

      // Assert.
      expect(result, equals(esperado));
    });
  });
}
```

## Development Guidelines

### When to Create a New Service

Create a new service when:
- ✅ The feature is used by multiple repositories or screens.
- ✅ The logic is complex and deserves to be isolated.
- ✅ The feature does not naturally belong in a repository.
- ✅ You need to coordinate multiple data sources.

Do **NOT** create a service when:
- ❌ The logic is specific to a single repository (put it in the repository).
- ❌ It is a simple helper function (use utils).
- ❌ It is a data transformation (use extensions).
- ❌ It is simple validation (use validators in utils).

### Difference Between a Service and a Repository

| Aspect | Service | Repository |
|---------|---------|------------|
| **Purpose** | Cross-cutting business logic | Data access for an entity |
| **Dependencies** | May depend on multiple DAOs/APIs | Usually one primary DAO |
| **Scope** | Multiple entities/domains | One specific entity |
| **Example** | CodeGeneratorService, NotificationService | ProductRepository, CustomerRepository |

### Performance and Asynchrony

- Use `async/await` for asynchronous operations.
- Avoid synchronous operations that block the UI.
- Consider isolates for expensive operations.
- Cache results when appropriate.

### Error Handling

Repositories and services should:
1. Use internal `try/catch` blocks — **never** rethrow exceptions to BLoC/Cubit.
2. Return `ResultStatus<R, String>` with user-friendly messages through `mensagemErroRepositorio()` (`lib/core/utils/repository_error_mapper.dart`).
3. Log errors when appropriate (through `LoggerClassMixin` or similar).
4. Provide clear error messages in English.

Example (repository):
```dart
Future<ResultStatus<Customer, String>> buscar(int id) async {
  try {
    final row = await _dao.getById(id);
    return ResultStatus.success(row!.toCustomer());
  } catch (e) {
    return ResultStatus.error(
      mensagemErroRepositorio(e, contexto: 'Falha ao buscar cliente'),
    );
  }
}
```

The presentation layer does **not** wrap repository calls in `try/catch`; it uses `when` or `switch` on `ResultStatus`.

## Contributing

When adding a new service:

1. ✅ Create the file in `lib/domain/service_name_service.dart`.
2. ✅ Document all public methods in English.
3. ✅ Register it in `setupAppInjection()` (`lib/application/app_injection.dart`).
4. ✅ Add tests in `test/service_name_service_test.dart`.
5. ✅ Update this README with information about the new service.
6. ✅ If it is complex, add supporting documentation in `/documentation/` (living guides; historical material belongs in `documentation/historico/`).

## Additional Resources

- **Architecture documentation**: `/.github/copilot-instructions.md`
- **Dart code standards**: `/.github/instructions/dartcode.instructions.md`
- **Build Runner**: Run `dart run build_runner build` after changes to services that use code generation.
