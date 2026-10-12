# Product Category Widget

## Overview

`ProductCategory` is a reusable widget that simplifies selecting and creating product categories. It provides two interaction modes:

1. **Dropdown mode**: Select an existing category from a list.
2. **Manual mode**: Enter a new custom category.

## Features

### Smart Selection
- Automatically extracts unique categories from existing products.
- Sorts categories alphabetically.
- Ignores empty categories.

### Switching Modes
- Starts in dropdown mode when categories are available.
- The **+** (add) button switches to manual entry mode.
- The `Icons.list` button switches back to dropdown mode.
- Preserves the controller value when switching modes.

### Validation
- Supports required-field validation through the `required` parameter.
- Provides appropriate error messages for each mode.
- Integrates with Flutter's `Form`.

### State Management
- Automatically synchronizes with the `TextEditingController`.
- Updates the category list when products change.
- Initializes from an existing controller value.

### Accessibility
- Supports enabling/disabling through the `enabled` parameter.
- Provides an `onChanged` callback for category changes.
- Adds descriptive tooltips to action buttons.

## Usage

### Basic Example

```dart
final categoriaController = TextEditingController();
final produtos = [...]; // Existing products

ProductCategory(
  controller: categoriaController,
  produtos: produtos,
)
```

### With Required-Field Validation

```dart
ProductCategory(
  controller: categoriaController,
  produtos: produtos,
  required: true,
)
```

### With a Change Callback

```dart
ProductCategory(
  controller: categoriaController,
  produtos: produtos,
  onChanged: (novaCategoria) {
    print('Category changed to: $novaCategoria');
  },
)
```

### In Read-Only Mode

```dart
ProductCategory(
  controller: categoriaController,
  produtos: produtos,
  enabled: false,
)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|-------------|-----------|
| `controller` | `TextEditingController` | Yes | Controller for managing the category text |
| `produtos` | `List<Produto>` | Yes | Products from which existing categories are extracted |
| `required` | `bool` | No | When `true`, validates that the field is not empty (default: `false`) |
| `enabled` | `bool` | No | When `false`, disables the field (default: `true`) |
| `onChanged` | `ValueChanged<String?>?` | No | Callback invoked when the category changes |

## Integration

### ProductForm

The widget is integrated with `ProductForm`, replacing the original category `TextFormField`:

```dart
ProductForm(
  // ... other parameters
  categoriaController: _categoriaController,
  produtos: produtos, // Product list from the BLoC state
)
```

### ProductDetailScreen

It is also integrated with `ProductDetailScreen` for product editing:

```dart
ProductCategory(
  controller: _categoriaController,
  produtos: produtos, // List from the BLoC state
  enabled: _isEditing, // Enabled only in edit mode
)
```

## Detailed Behavior

### Initialization
- If there are no products, displays a text field.
- If products exist but the controller is empty, displays a dropdown.
- If the controller value matches an existing category, displays a dropdown with that category selected.
- If the controller value does not match an existing category, displays a text field containing that value.

### Category Extraction
1. Iterates over all products in the list.
2. Extracts the `categoria` field from each product.
3. Filters out empty categories.
4. Removes duplicates.
5. Sorts alphabetically.

### Switching Modes
**Dropdown → Manual:**
- Clears the dropdown selection.
- Retains the controller value, if present.

**Manual → Dropdown:**
- Clears the controller.
- Resets to the initial dropdown state.

## Tests

The widget has 18 automated tests covering:
- Conditional display (dropdown vs. text field)
- Unique category extraction
- Category selection
- Switching between modes
- Required-field validation
- Enable/disable behavior
- Change callbacks
- Initialization with values
- Dynamic category updates

Run the tests with:
```bash
flutter test test/product_category_widget_test.dart
```

## Design Pattern

The widget follows established project patterns:
- Complete documentation in English.
- Material 3 design.
- BLoC integration for state management.
- Validation consistent with other form widgets.
- Separation of responsibilities (a separate widget rather than inline code).

## Future Improvements

Potential improvements:
1. Autocomplete suggestions while typing.
2. Custom icons per category.
3. Customizable category colors.
4. A history of frequently used categories.
5. Category search/filtering when there are many options.
