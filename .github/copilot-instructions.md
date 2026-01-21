# System Loja - Copilot Instructions

## Architecture Overview

System Loja is a Flutter multiplatform store management app (Windows, macOS, iOS, Android) with **Drift ORM** as the primary persistence layer. The architecture follows clean architecture principles:

- **Domain Models** (`lib/core/models/`): Business entities with `@JsonSerializable` (Customer, Product, Invoice)
- **Drift Database** (`lib/data/database/`): Type-safe SQLite ORM with DAOs, Tables, and Extensions
- **Repository Layer** (`lib/core/repository/`): Abstracts data access, uses DAOs
- **BLoC/Cubit** (`lib/screens/*/bloc/`): State management with `flutter_bloc` and `freezed`
- **Dependency Injection** (`lib/screens/injection/app_injection.dart`): Singleton managing dependencies
- **Screens** (`lib/screens/`): Material 3 UI with BlocBuilder/BlocProvider
- **Legacy Managers** (`lib/core/managers/`): JSON-based managers (being phased out)

## Critical Patterns

### 1. Drift DAO Pattern (PRIMARY)
All database operations use Drift DAOs with type-safe queries:
```dart
// DAO implementation with @DriftAccessor
@DriftAccessor(tables: [ClientesRecords])
class ClienteDao extends DatabaseAccessor<AppDatabase> with _$ClienteDaoMixin {
  Future<List<Customer>> getAll() async {
    final records = await select(clientesRecords).get();
    return records.map((record) => record.toDomain()).toList();
  }
  
  Future<int> insertCliente(Customer customer) {
    return into(clientesRecords).insert(
      customer.toCompanion(),
      mode: InsertMode.insertOrReplace,
    );
  }
}
```
**Key Points:**
- DAOs convert between Drift records and domain models via extensions
- Use `toCompanion()` for inserts/updates, `toDomain()` for reading
- Extensions in `lib/data/database/extension/` handle conversions

### 2. ExecutionResult Pattern for Error Handling
Use `ExecutionResult<R, E>` sealed class for type-safe error handling:
```dart
ExecutionResult<Customer, String> resultado = await repository.buscar(id);

if (resultado.isSuccessful) {
  final customer = resultado.asSuccess;
  // Handle success
} else {
  final erro = resultado.asError;
  // Handle error
}
```
**Note:** Use `ExecutionResult`, not `OperationResult` or `Result`.

### 3. Code Generation Workflow
**CRITICAL: Always run after changes to:**
```bash
dart run build_runner build --delete-conflicting-outputs
```
Generates:
- **`.g.dart`**: `@JsonSerializable` models + `@DriftDatabase` + `@DriftAccessor` DAOs
- **`.freezed.dart`**: `@freezed` BLoC events/states

**When to run:**
- After modifying domain models (`lib/core/models/`)
- After changing Drift tables (`lib/data/database/table/`)
- After modifying DAOs (`lib/data/database/dao/`)
- After updating BLoC events/states

### 4. Repository Pattern
Repositories wrap DAOs and provide business-logic layer:
```dart
class ClienteRepository {
  final ClienteDao dao;
  
  ClienteRepository(this.dao);
  
  Future<List<Customer>> listar() async {
    return await dao.getAll();
  }
  
  Future<void> salvar(Customer cliente) async {
    await dao.insertCliente(cliente);
  }
}
```
**Access via AppInjection:**
```dart
final repository = AppInjection.instance.clienteRepository;
```

### 5. Domain ↔ Drift Conversions
Extensions bridge domain models and Drift tables:
```dart
// Extension: Drift Record → Domain Model
extension ClienteFromData on ClientesRecord {
  Customer toDomain() {
    return Customer(
      id: id,
      name: name,
      cpf: cpf,
      // ...
    );
  }
}

// Extension: Domain Model → Drift Companion
extension ClienteToCompanion on Customer {
  ClientesRecordsCompanion toCompanion({bool forUpdate = false}) {
    if (forUpdate) {
      return ClientesRecordsCompanion(
        id: Value(id),
        name: Value(name),
        lastUpdatedDate: Value(DateTime.now()),
        // ...
      );
    }
    return ClientesRecordsCompanion.insert(
      name: name,
      cpf: cpf,
      // ...
    );
  }
}
```

### 6. BLoC/Cubit with Freezed
State management uses BLoC pattern with repositories:
```dart
class CustomerBloc extends Bloc<CustomerBlocEvent, CustomerBlocState> {
  final ClienteRepository _customerRepository = 
      AppInjection.instance.clienteRepository;
  
  CustomerBloc() : super(const _Initial()) {
    on<_LoadCustomers>(_onLoadCustomers);
    on<_RegisterCustomer>(_onRegisterCustomer);
  }
  
  Future<void> _onRegisterCustomer(
    _RegisterCustomer event,
    Emitter<CustomerBlocState> emit,
  ) async {
    emit(const CustomerBlocState.loading());
    try {
      await _customerRepository.salvar(event.customer);
      final customers = await _customerRepository.listarMapeado();
      emit(CustomerBlocState.customersLoaded(customers: customers));
    } on CustomerException catch (e) {
      emit(CustomerBlocState.customerError(message: e.message));
    }
  }
}
```
**Events/States use `@freezed`:**
```dart
@freezed
sealed class CustomerBlocEvent with _$CustomerBlocEvent {
  const factory CustomerBlocEvent.registerCustomer({
    required Customer customer,
  }) = _RegisterCustomer;
}

@freezed
sealed class CustomerBlocState with _$CustomerBlocState {
  const factory CustomerBlocState.initial() = _Initial;
  const factory CustomerBlocState.loading() = _Loading;
  const factory CustomerBlocState.customersLoaded({
    required Map<int, Customer> customers,
  }) = _CustomersLoaded;
}
```

### 7. Dependency Injection (AppInjection)
Singleton managing all dependencies:
```dart
class AppInjection {
  static AppInjection get instance => _instance ??= AppInjection._internal();
  
  final AppDatabase appDatabase = AppDatabase();
  final SystemDatabase systemDatabase = SystemDatabase();
  
  late final ClienteRepository clienteRepository = ClienteRepository(
    ClienteDao(appDatabase),
  );
  late final SettingsService settingsService = SettingsService.injection();
  
  Future<void> initializeDependencies() async {
    await configurationRepository.initializeDependencies();
  }
}
```
**Usage in BLoC:**
```dart
final repository = AppInjection.instance.clienteRepository;
```
**Initialize in main.dart:**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInjection.instance.initializeDependencies();
  runApp(const SystemLojaApp());
}
```

### 8. File Name Safety
Use `FileNameStringExtensions` for cross-platform file names:
```dart
import 'package:system_loja/core/utils/string_extensions.dart';

final safeFileName = 'Cliente #123.json'.toSafeFileName();
// Result: 'Cliente_123.json'

// Available methods:
fileName.sanitizeFileName()      // Remove invalid chars
fileName.truncateFileName(200)   // Limit length
fileName.toAsciiFileName()       // Remove accents
fileName.isValidFileName()       // Validate
fileName.makeUniqueFileName()    // Add timestamp
```
## Development Workflows

### Adding New Entity with Drift + BLoC
1. **Domain Model**: Create in `lib/core/models/` with `@JsonSerializable`
   ```dart
   @JsonSerializable()
   class Product extends DefaultObject {
     final String name;
     final double price;
     // ...
   }
   ```

2. **Drift Table**: Create in `lib/data/database/table/`
   ```dart
   class ProductsRecords extends Table {
     IntColumn get id => integer().autoIncrement()();
     TextColumn get name => text()();
     RealColumn get price => real()();
   }
   ```

3. **Extensions**: Create conversions in `lib/data/database/extension/`
   ```dart
   extension ProductToCompanion on Product {
     ProductsRecordsCompanion toCompanion() { ... }
   }
   extension ProductFromData on ProductsRecord {
     Product toDomain() { ... }
   }
   ```

4. **DAO**: Create in `lib/data/database/dao/`
   ```dart
   @DriftAccessor(tables: [ProductsRecords])
   class ProductDao extends DatabaseAccessor<AppDatabase> { ... }
   ```

5. **Register in AppDatabase**: Add to `@DriftDatabase` annotation
   ```dart
   @DriftDatabase(
     tables: [..., ProductsRecords],
     daos: [..., ProductDao],
   )
   ```

6. **Repository**: Create in `lib/core/repository/`
   ```dart
   class ProductRepository {
     final ProductDao dao;
     // CRUD methods
   }
   ```

7. **Add to AppInjection**: Register repository
   ```dart
   late final ProductRepository productRepository = ProductRepository();
   ```

8. **BLoC/Cubit**: Create in `lib/screens/products/bloc/`
   - `product_bloc.dart` (main logic)
   - `product_bloc_event.dart` (sealed events with `@freezed`)
   - `product_bloc_state.dart` (sealed states with `@freezed`)

9. **Run codegen**: `dart run build_runner build --delete-conflicting-outputs`

10. **Screen**: Create UI in `lib/screens/products/` with `BlocProvider`

11. **Navigation**: Add to `home_screen.dart` or route configuration

### Testing Commands
```bash
# Run all tests
flutter test

# Specific test file
flutter test test/cliente_dao_test.dart

# Code generation (ALWAYS after model/table/dao changes)
dart run build_runner build --delete-conflicting-outputs

# Run on specific platform
flutter run -d windows
flutter run -d macos
flutter run -d chrome
```

### Debugging Drift Database
- **Database location**: `getApplicationSupportDirectory()/system_loja.db`
- **Schema version**: Check `AppDatabase.schemaVersion` (current: 2)
- **Inspect DB**: Use DB Browser for SQLite or drift_db_viewer
- **Reset in tests**: Create new `AppDatabase()` instance per test
- **Migrations**: Increment `schemaVersion` and implement migration logic

### Database Migrations
When changing schema:
1. Increment `schemaVersion` in `app_database.dart`
2. Implement migration in `onUpgrade` (or use drift migrations)
3. Test migration with old database files

## Code Style Requirements

### Documentation (CRITICAL)
**All code MUST be documented in Portuguese** using `///` comments:
```dart
/// Gerencia operações CRUD para clientes no banco SQLite.
///
/// Esta classe utiliza o padrão Repository e os métodos `toJson()`/`fromJson()`
/// gerados automaticamente para serialização.
class ClienteSqlManager {
  /// Insere um novo cliente no banco de dados.
  ///
  /// Lança [DatabaseException] se o CPF já existir (constraint UNIQUE).
  /// Retorna o ID gerado automaticamente.
  Future<int> inserir(Cliente cliente) async { ... }
}
```

### Naming Conventions
- **Code**: English (variables, methods, classes) - e.g., `saveClient()`, not `salvarCliente()`
- **Documentation**: Portuguese (comments, strings)
- **Exception**: Domain models can use Portuguese names (e.g., `Cliente`, `Produto`)

### Dependencies (Key Packages)
- **State Management**: `bloc`, `flutter_bloc`
- **Immutability**: `freezed`, `freezed_annotation`
- **Serialization**: `json_serializable`, `json_annotation`
- **Database (PRIMARY)**: `drift`, `drift_flutter`, `drift_dev`, `sqlite3_flutter_libs`
- **Navigation**: `auto_route`
- **Utilities**: `path_provider`, `path`, `intl`, `crypto`, `equatable`
- **Logging**: `log_custom_printer` (git dependency)

## Known Gotchas

1. **ExecutionResult Naming**: Use `ExecutionResult<R, E>` sealed class, NOT `OperationResult` or `Result`. Check with `isSuccessful` / `hasError`, access with `asSuccess` / `asError`.

2. **Build Runner**: ALWAYS run after ANY changes to:
   - Domain models with `@JsonSerializable`
   - Drift tables, DAOs, or AppDatabase
   - BLoC events/states with `@freezed`
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Drift Conversions**: 
   - Use `toCompanion()` for inserts/updates (creates Companion objects)
   - Use `toDomain()` to convert Drift records to domain models
   - Set `forUpdate: true` in `toCompanion()` when updating (includes ID)

4. **Schema Migrations**: 
   - Current schema version: 2 (see `AppDatabase.schemaVersion`)
   - Increment version when changing table structure
   - Old DB files need migration logic

5. **AppInjection Initialization**: Call `await AppInjection.instance.initializeDependencies()` in `main()` before `runApp()`.

6. **Legacy Code**: JSON managers in `lib/core/managers/` are deprecated. Use Drift DAOs + Repositories instead.

7. **File Names**: Always use `toSafeFileName()` from `FileNameStringExtensions` for cross-platform compatibility.

8. **Naming Conventions**:
   - Code: English (variables, methods, classes)
   - Documentation: Portuguese (`///` comments)
   - Domain models: Can use Portuguese names (Customer = Cliente)

9. **Drift Table Naming**: 
   - Table classes: `XxxRecords` (plural)
   - Generated record types: `XxxRecord` (singular)
   - DAOs: `XxxDao`