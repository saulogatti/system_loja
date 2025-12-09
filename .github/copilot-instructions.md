# System Loja - Copilot Instructions

## Architecture Overview

System Loja is a Flutter multiplatform store management app (Windows, macOS, iOS, Android) with **dual persistence**: JSON files (legacy) and SQLite database (new). The codebase is transitioning to a modern architecture with:

- **Models** (`lib/core/models/`): Data classes using `@JsonSerializable` for automatic serialization
- **Managers** (`lib/core/managers/`): Legacy JSON-based managers with file locking for concurrency
- **SQL Managers** (`lib/data/database/`): New SQLite-based managers using Repository pattern
- **BLoC** (`lib/screens/*/bloc/`): State management with `flutter_bloc` and `freezed` for events/states
- **Cache** (`lib/data/cache/`): Generic cache system with `FileSystemManager` mixin
- **Screens** (`lib/screens/`): Material 3 UI with forms and lists

## Critical Patterns

### 1. OperationResult Pattern for Error Handling
Use `OperationResult<T, E>` sealed class (not `Result`) for type-safe error handling:
```dart
OperationResult<Cliente, ClienteException> resultado = await manager.salvar(cliente);
switch (resultado) {
  case OperationSuccess(value: final cliente):
    // Handle success
  case OperationFailure(error: final erro):
    // Handle error with erro.message
}
```

### 2. Code Generation Workflow
**Always run after model changes:**
```bash
dart run build_runner build --delete-conflicting-outputs
```
Required for:
- `@JsonSerializable` models (generates `.g.dart`)
- `@freezed` BLoC events/states (generates `.freezed.dart`)

### 3. Manager Concurrency (JSON-based)
Managers use `synchronized` package + file locking for concurrent writes:
```dart
class ProdutoManager {
  static final Map<String, Lock> _fileLocks = {};
  
  Future<void> salvarDadosSincronizado() async {
    await _getLock().synchronized(() async {
      // Reload from disk to merge changes
      final dadosAtuais = _carregarDadosDoDisco();
      // Merge, then save
    });
  }
}
```

### 4. SQL Managers Pattern
New SQLite managers (in `lib/data/database/`) use `toJson()`/`fromJson()`:
```dart
class ClienteSqlManager {
  Future<int> inserir(Cliente cliente) async {
    final db = await _database;
    final map = cliente.toJson();
    map.remove('id'); // Let DB auto-increment
    return await db.insert(DatabaseConfig.tabelaClientes, map);
  }
}
```

### 5. BLoC with Freezed
Events and states use `@freezed` for immutability:
```dart
@freezed
sealed class ClienteBlocEvent with _$ClienteBlocEvent {
  const factory ClienteBlocEvent.salvarCliente({
    required String nome,
    required String cpf,
  }) = _SalvarCliente;
}

@freezed
sealed class ClienteBlocState with _$ClienteBlocState {
  const factory ClienteBlocState.initial() = _Initial;
  const factory ClienteBlocState.clienteAdicionado({required Cliente cliente}) = _ClienteAdicionado;
}
```

### 6. FileStorageUtility Mixin
For safe file storage with automatic directory setup:
```dart
mixin FileStorageUtility {
  AsyncMemoizer<String> _memoizer = AsyncMemoizer<String>();
  
  Future<String> _initializeDirectory() async { /* creates cache dir */ }
  Future<OperationResult<String, String>> fetchDataFromFile(String path) async { /* loads file */ }
  Future<bool> saveData(String path, Object data) async { /* saves data in file */ }
}
```

### 7. OperationResult use

For file operations, use `OperationResult<T, E>`:

```dart
final resultado = await fetchDataFromFile('data.json');
switch (resultado) {
  case OperationSuccess(value: final data):
    // Use data
  case OperationFailure(error: final errorMsg):
    // Handle error
}
```
## Development Workflows

### Adding New Feature with BLoC
1. **Model**: Create in `lib/core/models/` with `@JsonSerializable`
2. **Manager**: Create JSON manager in `lib/core/managers/` or SQL manager in `lib/data/database/`
3. **BLoC**: Create `bloc/` folder with:
   - `entity_bloc.dart` (main logic)
   - `entity_bloc_event.dart` (sealed events with `@freezed`)
   - `entity_bloc_state.dart` (sealed states with `@freezed`)
4. **Run codegen**: `dart run build_runner build --delete-conflicting-outputs`
5. **Screen**: Create UI in `lib/screens/entity/` with `BlocProvider` and `BlocBuilder`
6. **Navigation**: Add to `home_screen.dart`

### Testing Commands
```bash
flutter test                      # Run all tests
flutter test test/cliente_sql_manager_test.dart  # Specific test
dart run build_runner build --delete-conflicting-outputs  # After model changes
flutter run -d macos             # macOS
flutter run -d windows           # Windows
```

### Debugging Persistence
- **JSON files**: Check `data/` directory (created automatically)
- **SQLite**: Use `DatabaseHelper.resetInstance()` in tests
- **Cache**: Check app support directory via `CacheManager.instance`

### 7. File Name Safety
Use `FileNameStringExtensions` for safe file naming:
```dart
import 'package:system_loja/core/utils/string_extensions.dart';

// Sanitização completa (recomendado)
final safeFileName = 'Cliente 123 - Pedido#456.json'.toSafeFileName();

// Validação
if (fileName.isValidFileName()) {
  // Safe to use
}

// Métodos individuais disponíveis:
fileName.sanitizeFileName()      // Remove caracteres inválidos
fileName.truncateFileName(200)   // Limita comprimento
fileName.toAsciiFileName()       // Remove acentos
fileName.isReservedFileName()    // Verifica nomes reservados do Windows
fileName.makeUniqueFileName()    // Adiciona timestamp
```

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
- `bloc` / `flutter_bloc`: State management
- `freezed` / `freezed_annotation`: Immutable events/states
- `json_serializable` / `json_annotation`: Model serialization
- `sqflite` / `sqflite_common_ffi`: SQLite database
- `synchronized`: File locking for JSON managers
- `path_provider`: App directories
- `path`: File path manipulation
- `log_custom_printer`: Custom logging (via git dependency)

## Known Gotchas

1. **Dual Persistence**: Some entities use JSON (`lib/core/managers/`), others use SQLite (`lib/data/database/`). Check which system the entity uses before modifying.
2. **Build Runner**: After adding/modifying `@JsonSerializable` or `@freezed` classes, ALWAYS run `dart run build_runner build --delete-conflicting-outputs` before running the app.
3. **Resultado vs Result**: Use `Resultado<T, E>` (Portuguese) with `Sucesso` and `Erro`, not Dart's `Result`.
4. **File Locking**: JSON managers use both in-memory `Lock` (from `synchronized`) and file-system locks (`RandomAccessFile.lock`) for multi-process safety.
5. **SQL Tests**: Use `sqfliteFfiInit()` and `databaseFactory = databaseFactoryFfi` in test setup for desktop testing.
6. **CacheManager**: Singleton with `FileSystemManager` mixin, uses `Cacheable` interface for objects. Call `setupFileSystem()` before use.
7. **File Names**: Always use `toSafeFileName()` from `FileNameStringExtensions` when saving files to ensure cross-platform compatibility (handles invalid characters, length limits, reserved names, accents).