# Company Edit Screen - Build Instructions

## Overview
This implementation adds a new dedicated screen for editing company information with:
- CNPJ field displayed in read-only mode with formatting (XX.XXX.XXX/XXXX-XX)
- Reuses existing BLoC updateCompany event for persistence
- CNPJ is normalized (only digits) before saving
- All other fields are editable

## ⚠️ CRITICAL: Required Build Step

**You MUST run the following command before testing the application:**

```bash
dart run build_runner build --delete-conflicting-outputs
```

This command generates:
- `route_app.gr.dart` - Auto-generated route configuration including CompanyEditRoute

**Without running this command, the application will not compile** because:
- `CompanyEditRoute` is referenced in `company_view.dart` but not yet generated
- The auto_route generator needs to create the route class and arguments

## Changes Made

### 1. CNPJ Formatter (lib/core/utils/text_formatters.dart)
Added `CnpjTextInputFormatter` class that:
- Formats CNPJ as XX.XXX.XXX/XXXX-XX
- Limits to 14 digits
- Removes non-numeric characters automatically

### 2. Company Edit Screen (lib/screens/company/company_edit_view.dart)
New screen with:
- **@RoutePage() annotation** - Required for auto_route code generation
- CNPJ field in read-only mode (enabled: false)
- All other company fields editable
- Validation on required fields
- Cancel and Save buttons
- System information card (ID, registration date, last update)
- Uses existing `updateCompany` BLoC event
- Success/error handling with SnackBar
- Auto-navigation back to previous screen on success

### 3. Route Configuration (lib/screens/route/route_app.dart)
Added `CompanyEditRoute` to the routes list in the RouteApp class

### 4. Navigation (lib/screens/company/company_view.dart)
- Added "Editar" button to company details dialog
- Added `_abrirTelaEdicao()` method to navigate to edit screen
- Imports `CompanyEditRoute` from `route_app.gr.dart` (generated file)

## Testing Instructions

### 1. Generate Code (REQUIRED)
```bash
cd /home/runner/work/system_loja/system_loja
dart run build_runner build --delete-conflicting-outputs
```

### 2. Run the Application
```bash
flutter run
```

### 3. Test the Complete Flow
1. Navigate to Company screen
2. Create or select an existing company
3. Click on a company to view details
4. Click "Editar" button in the dialog
5. Verify:
   - CNPJ is displayed in formatted mode (XX.XXX.XXX/XXXX-XX)
   - CNPJ field is disabled (gray text, not editable)
   - All other fields are editable
   - Validation works on required fields (Razão Social)
   - Cancel button returns to previous screen
   - Save button updates the company
   - Success message is displayed
   - Updated data persists in the database
   - After save, returns to previous screen

## Key Implementation Details

### CNPJ Handling
- **Display**: CNPJ is formatted for display using `_formatCnpjForDisplay()` method
- **Storage**: CNPJ is stored as digits only (normalized) in the database
- **Read-only**: CNPJ field has `enabled: false` to prevent editing
- **Why read-only?** CNPJ is a unique identifier and should not be changed after registration

### State Management
- Uses existing `CompanyBloc` with `updateCompany` event
- Listens to `companiesLoaded` state with `updateCompany` stateType
- Shows success message and navigates back on successful update
- Shows error message on failure

### Form Validation
- **Razão Social**: required, minimum 3 characters
- **Email**: optional, validated via TextFormFieldEmail widget
- **CNPJ**: not validated (read-only field)
- **Other fields**: optional (street, zipCode, neighborhood, city)

### Navigation Flow
```
CompanyView (list)
  → Click company
    → Dialog with details + "Editar" button
      → Click "Editar"
        → CompanyEditView (full screen)
          → Edit fields + Save
            → Success message
              → Navigate back to CompanyView
```

## Architecture Alignment
This implementation follows the system architecture:
- **Domain Model**: Uses existing Company model
- **BLoC Pattern**: Reuses CompanyBloc and updateCompany event
- **Repository**: Uses existing CompanyRepository through BLoC
- **Routing**: Uses auto_route with @RoutePage annotation
- **Formatting**: Uses custom TextInputFormatter pattern
- **Validation**: Uses existing validators utility
- **Code Generation**: Requires build_runner for route generation

## Troubleshooting

### Error: "CompanyEditRoute is not defined"
**Solution**: Run `dart run build_runner build --delete-conflicting-outputs`

### Error: "Could not find a generator for route"
**Solution**: Ensure @RoutePage() annotation is present on CompanyEditView class

### CNPJ not displaying correctly
**Verify**: The `_formatCnpjForDisplay()` method formats 14 digits correctly
**Check**: Company CNPJ in database should be stored as 14 digits without formatting

### Changes not persisting
**Check**: 
- BLoC listener is properly connected
- updateCompany event is being dispatched
- Repository updateCompany method is being called
- Database update is successful

## Next Steps

1. ✅ Run `dart run build_runner build --delete-conflicting-outputs`
2. ✅ Run the application
3. ✅ Test the complete flow: view company → edit → save → verify update
4. Optional: Add delete button to edit screen if needed
5. Optional: Add more address fields (state, country) if needed
