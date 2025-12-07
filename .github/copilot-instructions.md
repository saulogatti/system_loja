# System Loja - Copilot Instructions

## Architecture Overview

System Loja is a Flutter multiplatform store management app (Windows, macOS, iOS, Android) using **JSON file persistence** instead of a database. The codebase follows a **Manager Pattern** with clear separation of concerns:

- **Models** (`lib/core/models/`): Data classes with `toJson()`/`fromJson()` serialization
- **Managers** (`lib/core/managers/`): Business logic classes that handle JSON file I/O and CRUD operations
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
- Modal bottom sheets for details with `showModalBottomSheet()`
- SnackBar feedback for user actions
- Card-based layouts with `InkWell` for interactions

## Development Workflow

### Adding New Features
1. **Model**: Create in `lib/core/models/` with JSON serialization
2. **Manager**: Create in `lib/core/managers/` with file I/O and business logic
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
- Validate required fields with `obrigatorio: true` pattern

### Dependencies
- `path_provider`: For file system access
- `path`: For file path operations
- No external database dependencies (uses JSON files)

## Common Tasks

### Adding New Entity Type
1. Create model in `lib/core/models/new_entity.dart`
2. Create manager in `lib/core/managers/new_entity_manager.dart`
3. Create screen in `lib/screens/new_entity_screen.dart`
4. Add navigation card to `home_screen.dart`

### Debugging JSON Issues
- Check `data/` directory for malformed JSON
- Verify `toJson()`/`fromJson()` methods match exactly
- Use `dart:convert` `jsonDecode`/`jsonEncode` consistently

This project prioritizes simplicity and local data persistence over complex database setups, making it ideal for desktop and mobile business applications across Windows, macOS, iOS, and Android platforms.

---

## Working with Issues

When working on issues assigned to you:

### Understanding Requirements
1. **Read the entire issue** including description, acceptance criteria, and comments
2. **Check for related issues** or PRs that might provide context
3. **Ask for clarification** if requirements are ambiguous (add a comment)
4. **Verify files mentioned** exist and understand their current state

### Implementation Strategy
1. **Start with models** if new entities are needed
2. **Then managers** for business logic
3. **Then screens** for UI
4. **Finally tests** to validate everything works

### Best Practices
- Make **minimal changes** - only modify what's necessary
- **Follow existing patterns** in the codebase
- **Test incrementally** as you build each component
- **Document your changes** in Portuguese
- **Use descriptive commit messages** following conventional commits

### Before Submitting PR
- [ ] Run `dart analyze` - no warnings
- [ ] Run `dart format .` - code is formatted
- [ ] Run `flutter test` - all tests pass
- [ ] Manual testing done - feature works as expected
- [ ] Documentation updated - if needed
- [ ] Code reviewed - self-review for quality

---

## Issue Templates

This repository provides structured issue templates:

### Bug Report Template
Use when reporting bugs. Include:
- Clear description of the bug
- Steps to reproduce
- Expected vs actual behavior
- Environment details (OS, Flutter version)
- Related files
- Acceptance criteria for the fix
- Logs/error messages

### Feature Request Template
Use when suggesting new features. Include:
- Clear description of the feature
- Problem it solves
- Proposed solution
- Files that will be impacted
- Detailed acceptance criteria
- Complexity estimate
- Mockups if applicable

**Both templates include acceptance criteria sections specifically designed to guide your work.**

---

## Pull Request Guidelines

### PR Title Format
Use conventional commit prefixes:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `refactor:` - Code refactoring
- `test:` - Test additions/modifications
- `chore:` - Maintenance tasks

Example: `feat: adiciona validação de CPF no cadastro de clientes`

### PR Description Should Include
1. **What was done** - Summary of changes
2. **Why it was done** - Reason/motivation
3. **How to test** - Steps to verify the changes
4. **Related issues** - Link to issue(s)
5. **Breaking changes** - If any (should be rare)

### Code Review Process
1. PRs will be reviewed by maintainers
2. Address feedback by updating the PR
3. Once approved, maintainer will merge
4. Branch will be deleted after merge

---

## Additional Resources

### Repository Documentation
- **CONTRIBUTING.md** - Full contribution guide for developers and Copilot Agent
- **SETUP_MCP.md** - Information about MCP server configuration
- **README.md** - Project overview and quick start
- **.github/instructions/** - File-specific instructions

### External Resources
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Documentation](https://flutter.dev/docs)
- [Material Design 3](https://m3.material.io/)
- [GitHub Copilot Best Practices](https://docs.github.com/en/copilot/tutorials/coding-agent/get-the-best-results)

### Getting Help
- Open an issue with label `question`
- Check existing documentation first
- Provide context when asking for help

---

**Remember**: Always prioritize code quality, maintainability, and following established patterns over speed. Take time to understand the codebase before making changes.