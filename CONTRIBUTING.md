# Contribution Guide - System Loja

## Welcome!

Thank you for considering contributing to System Loja! This document provides guidelines to help you work effectively on the project, either on your own or with the GitHub Copilot Coding Agent.

## 📋 Contents

- [Using the GitHub Copilot Coding Agent](#using-the-github-copilot-coding-agent)
- [Code Standards](#code-standards)
- [Workflow](#workflow)
- [Creating Issues](#creating-issues)
- [Creating Pull Requests](#creating-pull-requests)
- [Running Tests](#running-tests)
- [Project Structure](#project-structure)

---

## 🤖 Using the GitHub Copilot Coding Agent

The GitHub Copilot Coding Agent can help automate development tasks in this repository. For best results:

### Preparation

1. **Read the repository documentation** before creating issues:
   - `.github/copilot-instructions.md` - Technical instructions for Copilot
   - `.github/instructions/dartcode.instructions.md` - Dart code standards
   - This file (`CONTRIBUTING.md`) - General contribution guide

2. **Check the project conventions**:
   - **Clean Architecture**: UI → interfaces in `lib/core/interface/` → repositories in `lib/domain/repository/` → `lib/data/` (Drift, DTOs, mappers)
   - Primary persistence: **SQLite through Drift** (no external backend); JSON DTOs in `lib/data/entry/` when needed
   - Documentation in English, using `///` comments
   - Material Design 3 for the UI
   - Code generation: `dart run build_runner build` after changes to Freezed / JsonSerializable / Drift / AutoRoute

### Tasks Well Suited to the Copilot Agent

The Copilot Agent is most effective on well-defined tasks with a limited scope:

✅ **Good tasks for the Agent:**
- Add new fields to existing models
- Create form validations
- Fix specific, well-documented bugs
- Refactor code according to established standards
- Improve test coverage
- Update documentation
- Implement small, incremental features

❌ **Tasks to avoid assigning to the Agent:**
- Broad architectural changes
- Refactoring across multiple modules
- Critical security changes without supervision
- Ambiguous or poorly defined tasks

### Creating Issues for the Copilot Agent

For the Agent to work effectively, issues should be:

1. **Clear and specific**:
   ```markdown
   ❌ Bad: "Improve the customer screen"
   ✅ Good: "Add a 'Date of Birth' field to customer registration and validate that the customer is at least 18 years old"
   ```

2. **Include acceptance criteria**:
   ```markdown
   **Acceptance Criteria:**
   - [ ] The `dataNascimento` field has been added to the `Cliente` model
   - [ ] Validation for age >= 18 implemented
   - [ ] Field displayed in the registration form
   - [ ] Unit tests for the validation added
   - [ ] Documentation updated in English
   ```

3. **Specify affected files** (when possible):
   ```markdown
   **Expected Files:**
   - `lib/core/models/cliente.dart`
   - `lib/screens/cliente_screen.dart`
   - `test/models/cliente_test.dart`
   ```

4. **Provide the necessary context**:
   ```markdown
   **Context:**
   This field is needed to verify that a customer is an adult before
   allowing purchases. The form should display dates as DD/MM/YYYY, but
   store them as ISO 8601 in JSON.
   ```

### Reviewing Agent Pull Requests

Review Copilot Agent pull requests as you would review any developer's code:

1. **Review the code carefully**
2. **Run the tests**: `flutter test`
3. **Test the feature manually**
4. **Check that it follows** the project standards
5. **Request changes** if needed by mentioning `@copilot` in the comments
6. **Approve and merge** only after full validation

---

## 💻 Code Standards

### Naming Conventions

- **Files and directories**: `lowercase_with_underscores`
- **Classes and types**: `UpperCamelCase`
- **Variables and functions**: `lowerCamelCase`
- **Constants**: `lowerCamelCase` (preferred) or `UPPER_SNAKE_CASE`

### Documentation

**ALWAYS** document public code in **English**:

```dart
/// Manages customer CRUD operations through Drift.
///
/// All methods return [ResultStatus] — exceptions are not propagated to the UI.
class CustomerRepository implements ICustomerRepository {
  /// Finds a customer by ID.
  ///
  /// Returns [ResultStatus] with the [Customer] or a user-friendly error message.
  Future<ResultStatus<Customer, String>> buscar({required int id}) async { ... }
}
```

### Architectural Standards

#### Layers (current)

- **Interface + ResultStatus**: operations exposed to the UI return `ResultStatus<R, E>` (`lib/core/utils/result_status.dart`, which uses `package:meta`); do not propagate exceptions through a repository/interface.
- **Repositories** (`lib/domain/repository/`): coordinate DAOs and rules; use internal `try/catch` blocks and return `ResultStatus.error(mensagemErroRepositorio(...))` with user-friendly messages (`lib/core/utils/repository_error_mapper.dart`). They depend on interfaces and types from `lib/core/models/`.
- **Presentation** (`lib/screens/`): does **not** wrap repository calls in `try/catch`; uses `when`/`switch` on `ResultStatus` and emits an error state with the already-processed message.
- **Data** (`lib/data/`): Drift tables/DAOs, DTOs in `entry/`, and record-to-domain mapping; it does **not** import `domain/` or `application/`. `CacheManager` is registered through `GetIt` (DI) — do not use `CacheManager.instance`.
- **DI**: `setupAppInjection()` in `lib/application/app_injection.dart`; resolve dependencies with `appInjection.get<T>()`.

#### Persistence

- **Primary**: Drift (`AppDatabase` schema 12 / `SystemDatabase` schema 1); IDs auto-increment where a table uses `autoIncrement()`. `SystemDatabase` accepts an optional `QueryExecutor` in its constructor for in-memory database tests.
- **JSON DTOs**: in `lib/data/entry/` when needed (serialization/import). There is no `lib/core/managers/` directory.

### Flutter UI

- **Material Design 3** with `ColorScheme.fromSeed()`
- **Form validation** with `GlobalKey<FormState>()`
- **Modal bottom sheets** for details: `showModalBottomSheet()`
- **SnackBar** for user feedback
- Always **dispose** controllers

---

## 🔄 Workflow

### For Human Developers

1. **Fork** the repository.
2. **Create a branch** for your feature: `git checkout -b feature/minha-feature`
3. **Make frequent, descriptive commits.**
4. **Generate code** if you changed Freezed/JSON/Drift/AutoRoute: `dart run build_runner build`
5. **Run the tests**: `flutter test`
6. **Run the linter**: `dart analyze`
7. **Format the code**: `dart format .`
8. **Push** to your fork: `git push origin feature/minha-feature`
9. **Open a pull request** against the `main` branch.

### For the Copilot Coding Agent

1. **Assign an issue** to @copilot (automatically or manually).
2. **The Agent creates a branch** automatically.
3. **The Agent implements** the changes.
4. **The Agent opens a PR** for review.
5. **People review** and request changes if needed.
6. **The Agent iterates** based on feedback.
7. **People approve and merge** after validation.

---

## 📝 Creating Issues

Use the templates in `.github/ISSUE_TEMPLATE/`:

- **Bug Report** (`bug_report.md`): To report problems
- **Feature Request** (`feature_request.md`): To suggest improvements

### Important Elements

Every issue should include:

1. **A clear, concise title**
2. **A detailed description** of the problem or feature
3. **Acceptance criteria** (especially for the Copilot Agent)
4. **Additional context** (screenshots, logs, examples)
5. **Appropriate labels** (bug, enhancement, documentation, etc.)

### Example of a Good Issue

```markdown
# Add Email Validation to Customer Registration

## Description
The email field currently accepts any text. We need to validate
that the email is in a valid format before saving.

## Acceptance Criteria
- [ ] Validate the email format in the form
- [ ] Show a clear error message for an invalid email
- [ ] Do not allow saving a customer with an invalid email
- [ ] Add unit tests for the validation
- [ ] Update the documentation

## Affected Files
- `lib/screens/cliente_screen.dart`
- `test/screens/cliente_screen_test.dart`

## Additional Context
Use a standard email validation regex. Show the error below the field.
```

---

## 🔀 Creating Pull Requests

### PR Checklist

Before creating a PR, make sure that:

- [ ] The code follows the project standards.
- [ ] All tests pass: `flutter test`
- [ ] The code is formatted: `dart format .`
- [ ] There are no linter warnings: `dart analyze`
- [ ] Documentation is updated (if applicable).
- [ ] Comments are in English.
- [ ] Commits are descriptive and organized.

### Title and Description

**Title**: Use conventional prefixes:
- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `refactor:` for refactoring
- `test:` for adding/updating tests
- `chore:` for maintenance tasks

**Description**: Explain what was done and why.
```markdown
## What changed
- Added the `dataNascimento` field to the `Cliente` model
- Implemented minimum-age validation

## Why
To ensure that only people aged 18 or older can be registered.

## How to test
1. Run `flutter test`
2. Open the customer screen
3. Try to register a customer under 18
4. Verify that a validation error is displayed
```

---

## 🧪 Running Tests

### Unit Tests

```bash
# Run all tests
flutter test

# Run a specific test
flutter test test/models/cliente_test.dart

# Run with coverage
flutter test --coverage
```

### Manual Tests

```bash
# Desktop
flutter run -d windows
flutter run -d macos
flutter run -d linux

# Mobile (with an emulator/device)
flutter run

# Web
flutter run -d chrome
```

### Code Validation

```bash
# Analyze code
dart analyze

# Format code
dart format .

# Check formatting without applying changes
dart format --set-exit-if-changed .
```

---

## 📁 Project Structure

```
system_loja/
├── .github/
│   ├── copilot-instructions.md          # Instructions for the Copilot Agent
│   ├── instructions/
│   │   └── dartcode.instructions.md     # Dart code standards
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md
│       └── feature_request.md
├── lib/
│   ├── main.dart
│   ├── application/
│   │   └── app_injection.dart           # DI (GetIt)
│   ├── core/
│   │   ├── interface/                   # Contracts (e.g. ICustomerRepository)
│   │   ├── models/                      # Domain entities
│   │   ├── services/                    # Cross-cutting services (when applicable)
│   │   └── utils/                       # ResultStatus, helpers
│   ├── domain/
│   │   └── repository/                  # Repository implementations
│   ├── data/
│   │   ├── database/                    # Drift: DAOs, tables, mapper/, extension/
│   │   ├── entry/                       # JSON DTOs
│   │   ├── cache/, converter/, models/
│   └── screens/                         # UI, BLoC/Cubit, routes
├── test/
│   └── support/                         # Helpers (e.g. AppDatabase tests)
├── documentation/                       # Current Markdown guides
│   ├── dartdoc/                         # Source pages for categories
│   └── historico/                       # Historical material (non-canonical)
├── docs/                                # HTML from `dart doc -o docs/` (GitHub Pages)
├── dartdoc_options.yaml
├── CONTRIBUTING.md
└── README.md
```

### API Documentation

```bash
dart doc -o docs/
```

Publication: GitHub Pages with source = branch and directory `/docs`. Long-form guides belong in `documentation/`, not in `docs/`.

The application's primary data flow uses embedded SQLite through Drift.

---

## 🔗 Useful Links

- **Flutter documentation**: https://flutter.dev/docs
- **Effective Dart**: https://dart.dev/guides/language/effective-dart
- **Material Design 3**: https://m3.material.io/
- **GitHub Copilot Docs**: https://docs.github.com/en/copilot
- **Copilot Coding Agent Best Practices**: https://docs.github.com/en/copilot/tutorials/coding-agent/get-the-best-results

---

## 🆘 Need Help?

- Open an issue with the `question` label.
- Review the documentation in `.github/copilot-instructions.md`.
- See `README.md` for basic information.

---

## 📄 License

This is an open-source project. By contributing, you agree that your contributions will be licensed under the same terms as the project.

---

**Thank you for contributing to System Loja! 🚀**
