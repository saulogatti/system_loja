# System Loja - Copilot Instructions

## Architecture Overview

System Loja is a Flutter multiplatform store management app (Windows, macOS, iOS, Android) using **JSON file persistence** instead of a database. The codebase follows a **Manager Pattern** with clear separation of concerns:

- **Models** (`lib/models/`): Data classes with `toJson()`/`fromJson()` serialization
- **Managers** (`lib/managers/`): Business logic classes that handle JSON file I/O and CRUD operations
- **Screens** (`lib/screens/`): Material 3 UI screens with forms and lists
- **Data Persistence**: JSON files in `data/` directory (created automatically)

## Key Patterns

### Manager Pattern
Each entity has a dedicated manager class that handles:
```dart
class ClienteManager {
  List<Cliente> clientes = [];
  void _carregarDados() // Load from JSON file
  void _salvarDados()   // Save to JSON file
  // CRUD operations
}
```

### JSON Persistence
- Files stored in `data/` directory (`data/clientes.json`, `data/produtos.json`, etc.)
- Auto-generated IDs using: `clientes.isEmpty ? 1 : clientes.map((c) => c.id!).reduce((a, b) => a > b ? a : b) + 1`
- Models must have `toJson()` and `fromJson()` methods

### Flutter UI Patterns
- Material 3 design with `ColorScheme.fromSeed()`
- Form validation using `GlobalKey<FormState>()`
- Dialog popups for details with `showDialog()`
- SnackBar feedback for user actions
- Card-based layouts with `ListTile` for interactions

## Development Workflow

### Adding New Features
1. **Model**: Create in `lib/models/` with JSON serialization
2. **Manager**: Create in `lib/managers/` with file I/O and business logic
3. **Screen**: Create in `lib/screens/` with form and list UI
4. **Navigation**: Add to `home_screen.dart` menu

### Testing
```bash
flutter run -d macos     # macOS testing
flutter run -d windows   # Windows testing
flutter run              # iOS/Android (with simulator/device)
flutter test             # Unit tests
```

### Code Style
- Follow **Effective Dart** guidelines (configured in `analysis_options.yaml`)
- Use `lowerCamelCase` for variables/functions, `UpperCamelCase` for classes
- Prefer `final` over `var` for immutable variables
- **ALWAYS** document code using `///` comments in **Portuguese**
- Document all public classes, methods, and properties
- Use clear, descriptive Portuguese phrases following Dart doc comment patterns
- Format with `dart format`

## Critical Implementation Details

### Documentation Standards
All code must be documented in **Portuguese** using Dart doc comments:
```dart
/// Gerencia operações CRUD para clientes
///
/// Esta classe é responsável por carregar, salvar e manipular
/// dados de clientes em arquivos JSON locais.
class ClienteManager {
  /// Lista de todos os clientes carregados
  List<Cliente> clientes = [];

  /// Adiciona um novo cliente ao sistema
  ///
  /// Valida se o CPF já existe antes de adicionar.
  /// Retorna true se o cliente foi adicionado com sucesso.
  bool adicionarCliente(Cliente cliente) { ... }
}
```

### ID Generation
Always use this pattern for auto-incrementing IDs:
```dart
id: manager.items.isEmpty ? 1 : manager.items.map((i) => i.id!).reduce((a, b) => a > b ? a : b) + 1
```

### Manager File Paths
Default paths use relative `data/` directory:
```dart
ClienteManager({this.dataFile = 'data/clientes.json'})
```

### Form Controllers
Always dispose controllers in `dispose()` method:
```dart
@override
void dispose() {
  _nomeController.dispose();
  _cpfController.dispose();
  super.dispose();
}
```

### Error Handling
Use consistent validation patterns:
- Check for duplicates before saving (CPF, product codes)
- Show SnackBar with red background for errors
- Validate required fields with form validators returning error messages

### Dependencies
- `path_provider`: For file system access
- `path`: For file path operations
- No external database dependencies (uses JSON files)

## Common Tasks

### Adding New Entity Type
1. Create model in `lib/models/new_entity.dart`
2. Create manager in `lib/managers/new_entity_manager.dart`
3. Create screen in `lib/screens/new_entity_screen.dart`
4. Add navigation card to `home_screen.dart`

### Debugging JSON Issues
- Check `data/` directory for malformed JSON
- Verify `toJson()`/`fromJson()` methods match exactly
- Use `dart:convert` `jsonDecode`/`jsonEncode` consistently

This project prioritizes simplicity and local data persistence over complex database setups, making it ideal for desktop and mobile business applications across Windows, macOS, iOS, and Android platforms.
