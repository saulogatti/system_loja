# Refactoring the Settings Screen to the BLoC Pattern

## Overview

The settings screen was refactored to follow the BLoC (Business Logic Component) pattern, as requested in the PR comments. This refactoring improves separation of responsibilities, simplifies testing, and makes the code easier to maintain.

## Changes Made

### 1. BLoC Pattern Implementation

#### Structure Created

```
lib/screens/configuracoes/bloc/
├── configuracoes_bloc.dart   - Business logic
├── configuracoes_event.dart  - 6 events
└── configuracoes_state.dart  - 5 states
```

#### Implemented Events

1. `CarregarConfiguracoesEvent` - Loads initial settings.
2. `AtualizarConfiguracoesEvent` - Saves settings.
3. `RestaurarPadraoEvent` - Restores default values.
4. `RealizarBackupEvent` - Creates a backup.
5. `LimparLogsAntigosEvent` - Removes old logs.
6. `LimparTodosDadosEvent` - Clears all data.

#### Implemented States

1. `ConfiguracoesInitial` - Initial state.
2. `ConfiguracoesLoading` - Loading.
3. `ConfiguracoesLoaded` - Loaded successfully.
4. `ConfiguracoesSuccess` - Operation succeeded.
5. `ConfiguracoesError` - Operation failed.

### 2. UI Modularization

#### Before
- 1 file: `configuracoes_screen.dart` (739 lines).

#### After
- 1 main file: `configuracoes_screen.dart` (~350 lines).
- 6 modular widgets:
  - `secao_notificacoes.dart` (~100 lines)
  - `secao_tema.dart` (~80 lines)
  - `secao_backup.dart` (~85 lines)
  - `secao_limpeza.dart` (~100 lines)
  - `secao_seguranca.dart` (~85 lines)
  - `secao_banco_dados.dart` (~90 lines)

#### Benefits
- ✅ More readable and organized code.
- ✅ Reusable widgets.
- ✅ Easier to maintain and test.
- ✅ Better performance (smaller widgets).

### 3. Improved Documentation

All 15 fields in the `Configuracao` model now have complete documentation:

```dart
/// Controls whether notifications are enabled globally in the system.
final bool notificacoesAtivadas;

/// Minimum number of units in stock required to trigger an alert (1-50).
final int limiteEstoqueBaixo;

/// Automatic backup frequency: 'diario', 'semanal', or 'mensal'.
final String frequenciaBackup;
```

## Separation of Responsibilities

### Before (Manager Pattern)
```
ConfiguracoesScreen → ConfiguracaoManager → JSON
```

### After (BLoC Pattern)
```
ConfiguracoesScreen → ConfiguracoesBloc → ConfiguracaoManager → JSON
```

### Advantages
- The UI does not know about persistence details.
- The Manager can be mocked in BLoC tests.
- The BLoC can be tested independently of the UI.
- State is predictable and traceable.

## Dependencies Added

### `pubspec.yaml`
```yaml
dependencies:
  flutter_bloc: ^8.1.6  # State management
  equatable: ^2.0.5     # Event/state comparison
```

## UI Usage

### Before (StatefulWidget with Manager)
```dart
class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  final ConfiguracaoManager _manager = ConfiguracaoManager();
  late Configuracao _config;
  
  void _salvar() async {
    await _manager.atualizarConfiguracao(_config);
    // UI logic mixed with persistence
  }
}
```

### After (BLoC)
```dart
class ConfiguracoesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConfiguracoesBloc()..add(CarregarConfiguracoesEvent()),
      child: BlocConsumer<ConfiguracoesBloc, ConfiguracoesState>(
        listener: (context, state) {
          if (state is ConfiguracoesSuccess) {
            // Show success
          }
        },
        builder: (context, state) {
          if (state is ConfiguracoesLoaded) {
            return _buildContent(state.configuracao);
          }
          // Other states...
        },
      ),
    );
  }
}
```

## Tests

### Testability

**The BLoC can be tested in isolation:**
```dart
test('should emit ConfiguracoesSuccess when updating', () async {
  final mockManager = MockConfiguracaoManager();
  final bloc = ConfiguracoesBloc(manager: mockManager);
  
  bloc.add(AtualizarConfiguracoesEvent(config));
  
  await expectLater(
    bloc.stream,
    emitsInOrder([
      ConfiguracoesLoading(),
      ConfiguracoesSuccess(config, 'Sucesso'),
      ConfiguracoesLoaded(config),
    ]),
  );
});
```

## Final Directory Structure

```
lib/screens/configuracoes/
├── configuracoes_screen.dart    # Main screen
├── bloc/                         # Business logic
│   ├── configuracoes_bloc.dart
│   ├── configuracoes_event.dart
│   └── configuracoes_state.dart
└── widgets/                      # UI components
    ├── secao_notificacoes.dart
    ├── secao_tema.dart
    ├── secao_backup.dart
    ├── secao_limpeza.dart
    ├── secao_seguranca.dart
    └── secao_banco_dados.dart
```

## Next Steps

1. ✅ Migrate other screens to the BLoC pattern.
2. ✅ Add unit tests for ConfiguracoesBloc.
3. ✅ Add widget tests for the components.
4. ✅ Document the BLoC pattern in the README.

## References

- [flutter_bloc Documentation](https://bloclibrary.dev/)
- [Effective BLoC Pattern](https://verygood.ventures/blog/effective-bloc-pattern)
- [BLoC Architecture Tutorial](https://bloclibrary.dev/#/architecture)

---

**Commit:** 4451857<br>
**Date:** December 2024
**Author:** @copilot
