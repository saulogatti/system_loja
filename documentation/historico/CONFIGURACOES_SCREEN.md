# System Settings Screen

## Overview

The settings screen (`ConfiguracoesScreen`) allows administrators to adjust general system preferences, including notifications, appearance, backups, data cleanup, security, and database type.

## Interface Structure

### AppBar
- **Title**: "System Settings"
- **Action**: Button to restore default settings (restore icon)

### Body (Scrollable)

#### 1. Notifications Section 🔔
Configure system alerts:

- **Enable notifications** (Switch)
  - Enables/disables all notifications
  
- **Notify about sales** (Switch)
  - Alerts about new sales
  - Disabled when notifications are turned off
  
- **Notify about low stock** (Switch)
  - Alerts when products reach the minimum threshold
  - Disabled when notifications are turned off
  
- **Low-stock threshold** (Slider: 1-50)
  - Sets the number of units that triggers an alert
  - Visible only when "Notify about low stock" is enabled

#### 2. Appearance Section 🎨
Customize the app's appearance:

- **Dark theme** (Switch)
  - Toggles between light and dark modes
  
- **Primary color** (Picker)
  - Selects the app's primary color
  - Available options:
    - Blue (#2196F3) - Default
    - Green (#4CAF50)
    - Orange (#FF9800)
    - Purple (#9C27B0)
    - Red (#F44336)
    - Pink (#E91E63)
    - Cyan (#00BCD4)
    - Indigo (#3F51B5)

#### 3. Backup Section 💾
Manage backups:

- **Automatic backup** (Switch)
  - Enables scheduled backups
  
- **Backup frequency** (Picker)
  - Options: Daily, Weekly, Monthly
  - Visible only when automatic backup is enabled
  
- **Back up now** (Button)
  - Immediately creates a manual copy of the data
  - Files are saved in: `data/backups/[timestamp]/`
  - Includes: customers, products, invoices, users, logs, and settings

#### 4. Data Cleanup Section 🧹
Maintain and remove data:

- **Automatic log cleanup** (Switch)
  - Automatically removes old logs
  
- **Days to retain logs** (Slider: 7-365)
  - Sets how long records are retained
  - Visible only when automatic cleanup is enabled
  
- **Clear old logs now** (Button)
  - Removes logs based on the current setting
  - Requires confirmation
  
- **Clear all data** (Button - Red)
  - ⚠️ IRREVERSIBLE ACTION
  - Removes ALL system data
  - Requires double confirmation with a warning

#### 5. Security Section 🔒
Protection and access options:

- **Require password** (Switch)
  - Requests authentication when opening the app
  
- **Lock timeout** (Slider: 1-60 minutes)
  - Inactivity duration before requesting a password
  - Visible only when "Require password" is enabled
  
- **Allow multiple users** (Switch)
  - Enables user management

#### 6. Database Section 🗄️
Choose the persistence system:

- **JSON (Local files)** (Radio)
  - Lightweight and simple
  - Recommended for basic use
  - System default
  
- **SQL (SQLite)** (Radio)
  - More robust
  - Recommended for large amounts of data
  - Requires restarting the app

**Note**: Changing the database type requires restarting the app.

### Save Button
- **Location**: Bottom of the screen
- **Function**: Persists all changes
- **Style**: Prominent button with a save icon
- **Feedback**: Green SnackBar on success, red on error

## Special Features

### Restore Defaults
- Accessed through the AppBar icon
- Requires confirmation
- Restores ALL settings to their initial values

### Validation
- All values are validated before saving.
- Each action provides visual feedback (SnackBars).
- A loading indicator is shown during asynchronous operations.

### Persistence
- Settings are saved in: `data/configuracao.json`
- Settings load automatically when the screen opens.
- Thread-safe through synchronization locks.

## Related Files

### Model
- `lib/core/models/configuracao.dart` - Data structure definition
- `lib/core/models/configuracao.g.dart` - JSON serialization (generated)

### Manager
- `lib/core/managers/configuracao_manager.dart` - Business logic

### UI
- `lib/screens/configuracoes_screen.dart` - Graphical interface

### Tests
- `test/configuracao_manager_test.dart` - 13 unit tests

## Navigation

Access from the home screen (`HomeScreen`):
- "System Settings" card
- Icon: Settings (gear)
- Color: Teal

## Default Values

```dart
Configuracao.padrao() {
  notificacoesAtivadas: true,
  notificarVendas: true,
  notificarEstoqueBaixo: true,
  limiteEstoqueBaixo: 10,
  temaEscuro: false,
  corPrimaria: '#2196F3', // Blue
  backupAutomatico: false,
  frequenciaBackup: 'semanal',
  localBackup: 'data/backups',
  limpezaAutomatica: false,
  diasManterLogs: 90,
  exigirSenha: false,
  tempoBloqueioMinutos: 15,
  permitirMultiplosUsuarios: false,
  tipoBancoDados: 'json',
}
```

## Asynchronous Operations

All operations that modify data are asynchronous and display a loading indicator:
- Save settings
- Restore defaults
- Create a backup
- Clear logs
- Clear all data

## Error Handling

All operations handle errors with:
- Try-catch blocks
- Error logging
- Visual feedback to the user (red SnackBar)
- Descriptive messages

## UX Considerations

1. **Visual hierarchy**: Cards are grouped by functionality.
2. **Immediate feedback**: Switches and sliders update state instantly.
3. **Confirmations**: Destructive actions require explicit confirmation.
4. **Accessibility**: All controls have descriptive labels.
5. **Responsiveness**: `SingleChildScrollView` supports small screens.
6. **Consistency**: Follows Material Design 3.

## Potential Future Improvements

- [ ] Import/export settings
- [ ] Automatic cloud backups
- [ ] More custom color options
- [ ] Schedule cleanups
- [ ] Storage usage statistics
- [ ] Real-time theme preview
- [ ] Automatic dark mode support (follow system settings)
- [ ] Per-module settings (customer, product, etc.)
