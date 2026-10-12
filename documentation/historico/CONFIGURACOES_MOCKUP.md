# Settings Screen Mockup

## Visual Layout

```
┌─────────────────────────────────────────────────────────────────────┐
│  ← System Settings                                      ⟲ Restore│
├─────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 🔔 Notifications                                              │  │
│  ├──────────────────────────────────────────────────────────────┤  │
│  │                                                               │  │
│  │  ⚫ Enable notifications                       ◉ ON          │  │
│  │     Receive system alerts                                    │  │
│  │                                                               │  │
│  │  ⚫ Notify about sales                         ◉ ON          │  │
│  │     Alerts about new sales                                    │  │
│  │                                                               │  │
│  │  ⚫ Notify about low stock                     ◉ ON          │  │
│  │     Alerts when stock is low                                  │  │
│  │                                                               │  │
│  │  📊 Low-stock threshold                                      │  │
│  │     ├──────────●──────────────────────────────┤ 10 units     │  │
│  │     1                                       50                │  │
│  │                                                               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 🎨 Appearance                                                 │  │
│  ├──────────────────────────────────────────────────────────────┤  │
│  │                                                               │  │
│  │  ⚫ Dark theme                                  ○ OFF         │  │
│  │     Enable dark mode                                         │  │
│  │                                                               │  │
│  │  🎨 Primary color                                         ▣    │  │
│  │     Main application color                         [Blue]    │  │
│  │                                                        →      │  │
│  │                                                               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 💾 Data Backup                                                │  │
│  ├──────────────────────────────────────────────────────────────┤  │
│  │                                                               │  │
│  │  ⚫ Automatic backup                           ○ OFF         │  │
│  │     Create backups periodically                               │  │
│  │                                                               │  │
│  │  💾 Back up now                                          →    │  │
│  │     Create a manual copy of the data                         │  │
│  │                                                               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 🧹 Data Cleanup                                               │  │
│  ├──────────────────────────────────────────────────────────────┤  │
│  │                                                               │  │
│  │  ⚫ Automatic log cleanup                       ○ OFF         │  │
│  │     Automatically remove old logs                            │  │
│  │                                                               │  │
│  │  🧹 Clear old logs now                                   →    │  │
│  │     Remove logs based on the current setting                 │  │
│  │                                                               │  │
│  │  ⚠️  Clear all data                                      →    │  │
│  │     Remove ALL system data                       [RED]       │  │
│  │                                                               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 🔒 Security                                                   │  │
│  ├──────────────────────────────────────────────────────────────┤  │
│  │                                                               │  │
│  │  ⚫ Require password                            ○ OFF         │  │
│  │     Request a password when opening the app                  │  │
│  │                                                               │  │
│  │  ⚫ Allow multiple users                        ○ OFF         │  │
│  │     Enable user management                                    │  │
│  │                                                               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 🗄️  Database                                                  │  │
│  ├──────────────────────────────────────────────────────────────┤  │
│  │                                                               │  │
│  │  ◉ JSON (Local files)                                        │  │
│  │     Lightweight and simple; recommended for basic use        │  │
│  │                                                               │  │
│  │  ○ SQL (SQLite)                                               │  │
│  │     More robust; recommended for large amounts of data       │  │
│  │                                                               │  │
│  │  ℹ️  Note: Changing the database type requires               │  │
│  │     restarting the application.                              │  │
│  │                                                               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │                       💾 SAVE SETTINGS                         │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
└─────────────────────────────────────────────────────────────────────┘
```

## Interactions by Section

### 1. Header (AppBar)
- **Back button (←)**: Returns to the home screen
- **Title**: "System Settings"
- **Restore button (⟲)**: Opens a confirmation dialog to restore defaults

### 2. Notifications (Blue Card)
- **Master toggle**: Controls all notifications
- **Sales toggle**: Enables/disables sales notifications
- **Stock toggle**: Enables/disables low-stock alerts
- **Threshold slider**: Adjusts the threshold (1-50 units) with a value preview

### 3. Appearance (Green Card)
- **Theme toggle**: Turns dark mode on/off
- **Color picker**: Opens a modal with 8 color options
  - Shows a preview of the current color
  - Colors: Blue, Green, Orange, Purple, Red, Pink, Cyan, Indigo

### 4. Backup (Orange Card)
- **Automatic toggle**: Enables scheduled backups
- **Frequency picker**: Modal with options (Daily/Weekly/Monthly)
  - Appears only when automatic backup is enabled
- **Manual button**: Runs a backup immediately
  - Shows progress and result

### 5. Cleanup (Light Red Card)
- **Automatic toggle**: Enables automatic cleanup
- **Days slider**: Sets log retention (7-365 days)
  - Appears only when automatic cleanup is enabled
- **Clear logs button**: Removes old logs
  - Requires confirmation
- **Clear all button**: Removes ALL data
  - Prominent red button
  - Requires double confirmation with a severe warning

### 6. Security (Purple Card)
- **Password toggle**: Enables authentication
- **Lock slider**: Sets the timeout (1-60 minutes)
  - Appears only when password protection is enabled
- **Users toggle**: Enables multi-user support

### 7. Database (Gray Card)
- **JSON radio button**: Selects file-based persistence
  - Selected by default
  - Description: "Lightweight and simple"
- **SQL radio button**: Selects SQLite persistence
  - Description: "More robust"
- **Informational note**: Warns that a restart is required

### 8. Save Button (Footer)
- **Style**: Large, prominent button
- **Color**: Primary blue with white text
- **Icon**: Save disk
- **Feedback**: Green SnackBar on success or red on error

## Interaction Flows

### Save Settings
```
1. The user changes values.
2. Clicks "SAVE SETTINGS".
3. A loading indicator appears.
4. Data is persisted to JSON.
5. A SnackBar confirms success or failure.
6. State is updated in memory.
```

### Create a Backup
```
1. The user clicks "Back up now".
2. The system creates a timestamped folder.
3. JSON files are copied.
4. The SnackBar displays the result.
   - Green: "Backup completed successfully!"
   - Red: "Error creating backup"
```

### Clear All Data
```
1. The user clicks "Clear all data".
2. A confirmation modal appears:
   ┌────────────────────────────────────┐
   │         ⚠️  WARNING!                │
   ├────────────────────────────────────┤
   │ This action will REMOVE ALL        │
   │ SYSTEM DATA (customers, products,  │
   │ invoices, users, and logs).        │
   │                                    │
   │ This action CANNOT be undone!      │
   │                                    │
   │ Are you sure you want to continue? │
   ├────────────────────────────────────┤
   │ [Cancel]  [Yes, Clear All] 🔴      │
   └────────────────────────────────────┘
3. If confirmed:
   - All JSON files are cleared.
   - Orange SnackBar: "All data has been removed!"
```

### Restore Defaults
```
1. The user clicks the ⟲ icon in the AppBar.
2. A confirmation modal appears:
   ┌────────────────────────────────────┐
   │   Restore Settings                 │
   ├────────────────────────────────────┤
   │ Do you want to restore all         │
   │ settings to their defaults?        │
   ├────────────────────────────────────┤
   │    [Cancel]      [Restore]         │
   └────────────────────────────────────┘
3. If confirmed:
   - Values return to their defaults.
   - The UI is updated.
   - Green SnackBar: "Settings restored!"
```

### Color Picker
```
1. The user clicks "Primary color".
2. A modal appears with these options:
   ┌────────────────────────────────────┐
   │       Choose a Color               │
   ├────────────────────────────────────┤
   │  ▣ Blue                            │
   │  ▣ Green                           │
   │  ▣ Orange                          │
   │  ▣ Purple                          │
   │  ▣ Red                             │
   │  ▣ Pink                            │
   │  ▣ Cyan                            │
   │  ▣ Indigo                          │
   └────────────────────────────────────┘
3. The user selects a color.
4. The modal closes.
5. The preview updates instantly.
```

## Conditional States

### Notifications Disabled
- Sub-options are grayed out.
- The threshold slider is hidden.
- Sales/stock toggles are disabled.

### Automatic Backup Disabled
- The frequency picker is hidden.

### Automatic Cleanup Disabled
- The days slider is hidden.

### Password Disabled
- The lock-timeout slider is hidden.

## Responsiveness

### Desktop (> 800px)
- Cards use a centered maximum width of 600px.
- Generous horizontal padding.

### Tablet (400-800px)
- Cards use 90% of the available width.
- Moderate padding.

### Mobile (< 400px)
- Cards use 100% of the available width.
- Scrolling is enabled.
- Minimal padding maximizes the available space.

## Accessibility

- ✅ Descriptive labels on all controls
- ✅ Explanatory subtitles
- ✅ Informative icons
- ✅ Adequate color contrast
- ✅ Clear visual feedback
- ✅ Confirmations for destructive actions
- ✅ Tooltips on AppBar buttons

## Performance

- ⚡ Optimized rendering with local setState
- ⚡ Background I/O operations
- ⚡ Loading indicators during asynchronous operations
- ⚡ Immediate validation
- ⚡ Responsive, smooth UI

## Compatibility

- ✅ Windows
- ✅ macOS
- ✅ Linux
- ✅ iOS
- ✅ Android
- ✅ Web
