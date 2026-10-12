# Validation and Formatting System

This document describes the field-validation and input-formatting system implemented in System Loja.

## Overview

The system provides reusable validators and input formatters to ensure that user-entered data is valid and consistent. This improves the user experience and data integrity.

## Components

### 1. Validators (`lib/screens/utils/validators.dart`)

Validators are functions that return `null` when a value is valid, or an error message otherwise.

#### Available Validators

##### `validatePrice(String? value)`
Validates monetary prices.

**Rules:**
- Must not be empty.
- Must be a valid number.
- Must not be negative.
- Maximum of 2 decimal places.
- Accepts a comma or period as the decimal separator.

**Example:**
```dart
TextFormField(
  validator: validatePrice,
  // ...
)
```

**Accepted values:**
- `10.50` ✅
- `10,50` ✅
- `0` ✅
- `100` ✅

**Rejected values:**
- `-10.50` ❌ (negative)
- `abc` ❌ (not numeric)
- `10.505` ❌ (more than 2 decimal places)

##### `validateQuantity(String? value)`
Validates quantities and counts.

**Rules:**
- Must not be empty.
- Must be a valid integer.
- Must not be negative.

**Example:**
```dart
TextFormField(
  validator: validateQuantity,
  // ...
)
```

##### `validateStock(String? value)`
Validates stock values (identical to `validateQuantity`).

**Example:**
```dart
TextFormField(
  validator: validateStock,
  // ...
)
```

##### `validateProductCode(String? value)`
Validates product codes.

**Rules:**
- Must not be empty.
- Minimum of 3 characters.
- Maximum of 20 characters.
- Letters, numbers, and hyphens only.

**Example:**
```dart
TextFormField(
  validator: validateProductCode,
  // ...
)
```

**Accepted values:**
- `ABC-123` ✅
- `PROD001` ✅
- `12345` ✅

**Rejected values:**
- `AB` ❌ (too short)
- `ABC@123` ❌ (invalid character)
- `ABC_123` ❌ (underscores are not allowed)

##### `validateRequired(String? value, String fieldName)`
Validates required fields.

**Example:**
```dart
TextFormField(
  validator: (value) => validateRequired(value, 'Nome'),
  // ...
)
```

##### `validateMinLength(String? value, int minLength, String fieldName)`
Validates the minimum length.

**Example:**
```dart
TextFormField(
  validator: (value) => validateMinLength(value, 3, 'Nome'),
  // ...
)
```

##### `combineValidators(List<String? Function(String?)> validators)`
Combines multiple validators.

**Example:**
```dart
TextFormField(
  validator: combineValidators([
    (value) => validateRequired(value, 'Nome'),
    (value) => validateMinLength(value, 3, 'Nome'),
  ]),
  // ...
)
```

### 2. Input Formatters (`lib/screens/utils/input_formatters.dart`)

Formatters automatically apply formatting rules as the user types, filtering out invalid characters.

#### Available Formatters

##### `PriceInputFormatter()`
Formats price fields.

**Features:**
- Allows only numbers and a decimal separator (period or comma).
- Automatically converts commas to periods.
- Limits input to 2 decimal places.
- Allows only one decimal separator.

**Example:**
```dart
TextFormField(
  inputFormatters: [PriceInputFormatter()],
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  // ...
)
```

**Behavior:**
- Input: `10,50` → Output: `10.50`
- Input: `10.505` → Output: `10.50`
- Input: `R$ 10.50` → Output: `10.50`

##### `QuantityInputFormatter()`
Formats quantity fields.

**Features:**
- Allows digits only.
- Removes any non-numeric characters.

**Example:**
```dart
TextFormField(
  inputFormatters: [QuantityInputFormatter()],
  keyboardType: TextInputType.number,
  // ...
)
```

**Behavior:**
- Input: `10.5` → Output: `105`
- Input: `10a5` → Output: `105`

##### `ProductCodeInputFormatter()`
Formats product codes.

**Features:**
- Allows only letters, numbers, and hyphens.
- Automatically converts text to uppercase.
- Removes spaces and special characters.

**Example:**
```dart
TextFormField(
  inputFormatters: [ProductCodeInputFormatter()],
  // ...
)
```

**Behavior:**
- Input: `abc-123` → Output: `ABC-123`
- Input: `ABC 123` → Output: `ABC123`
- Input: `ABC@123` → Output: `ABC123`

### 3. Custom Exceptions

#### `ValidationException` (`lib/core/exceptions/validation_exception.dart`)
Represents validation errors with detailed messages.

**Example:**
```dart
throw ValidationException(
  'Preço inválido',
  field: 'preco',
  suggestion: 'Use apenas números positivos com até 2 casas decimais',
  invalidValue: -10.50,
);
```

#### `ProductException` (`lib/core/exceptions/product_exception.dart`)
Represents errors specific to product operations.

**Example:**
```dart
throw ProductException.invalidPrice('PROD-001', -10.50);
throw ProductException.duplicateCode('PROD-001');
throw ProductException.insufficientStock('PROD-001', available: 5, requested: 10);
```

## Practical Usage

### Complete Example: Price Field

```dart
TextFormField(
  controller: _precoController,
  decoration: const InputDecoration(
    labelText: 'Preço (R\$) *',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.attach_money),
    helperText: 'Ex: 10.50',
  ),
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  inputFormatters: [PriceInputFormatter()],
  validator: validatePrice,
)
```

### Complete Example: Quantity Field

```dart
TextFormField(
  controller: _quantidadeController,
  decoration: const InputDecoration(
    labelText: 'Quantidade *',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.inventory),
    helperText: 'Ex: 10',
  ),
  keyboardType: TextInputType.number,
  inputFormatters: [QuantityInputFormatter()],
  validator: validateQuantity,
)
```

### Complete Example: Combined Validators

```dart
TextFormField(
  controller: _nomeController,
  decoration: const InputDecoration(
    labelText: 'Nome *',
    border: OutlineInputBorder(),
  ),
  validator: combineValidators([
    (value) => validateRequired(value, 'Nome'),
    (value) => validateMinLength(value, 3, 'Nome'),
  ]),
)
```

## Updated Screens

The following screens have been updated to use the new validation system:

1. **Products** (`lib/screens/products/product_screen.dart`)
   - Price field: `PriceInputFormatter` + `validatePrice`
   - Stock field: `QuantityInputFormatter` + `validateStock`
   - Code field: `ProductCodeInputFormatter` + `validateProductCode`

2. **Sales** (`lib/screens/sales/sales_screen.dart`)
   - Quantity field: `QuantityInputFormatter` + stock validation
   - Required fields: `validateRequired`

3. **Customers** (`lib/screens/person_registration/customer_edit_view.dart`)
   - Name field: combined validation (required + minLength)

4. **Users** (`lib/screens/configuracoes/usuario_screen.dart`)
   - Name field: combined validation (required + minLength)

## Tests

The validators and formatters have comprehensive tests:

- **Validators**: `test/validators_test.dart` (40+ test cases)
- **Formatters**: `test/input_formatters_test.dart` (35+ test cases)

Run the tests with:
```bash
flutter test test/validators_test.dart
flutter test test/input_formatters_test.dart
```

## Best Practices

1. **Always combine formatters with validators.**
   - Formatters prevent invalid input.
   - Validators ensure the final value is correct.

2. **Use helper text to guide the user.**
   - Provide examples of the expected format.
   - Indicate limitations (e.g., available stock).

3. **Use specific error messages.**
   - Use the provided validators, which already have clear messages.
   - Avoid generic messages such as "Invalid value".

4. **Validate progressively.**
   - Use `combineValidators` to apply multiple rules in order.
   - The first failing rule returns its message.

5. **Be consistent.**
   - Use the same validators and formatters in similar contexts.
   - Maintain a consistent error-message style.

## Next Steps

To add validation to a new screen:

1. Import the required utilities:
   ```dart
   import 'package:system_loja/core/utils/validators.dart';
   import 'package:system_loja/core/utils/input_formatters.dart';
   ```

2. Add formatters to the fields:
   ```dart
   inputFormatters: [PriceInputFormatter()],
   ```

3. Add validators to the fields:
   ```dart
   validator: validatePrice,
   ```

4. Test validation manually and add automated tests as needed.

## Contributing

When adding validators or formatters:

1. Document the expected behavior.
2. Add usage examples.
3. Write comprehensive tests.
4. Update this documentation.
5. Keep user-facing error messages in Portuguese.
6. Follow the existing naming conventions.
