# Code Generator - Usage Guide

## Overview

`CodeGeneratorService` automatically generates unique codes for products and invoices in System Loja. It prevents duplicate codes and allows users to provide custom codes after validation.

## Features

- ✅ Automatic generation of unique product codes
- ✅ Automatic generation of unique invoice numbers
- ✅ Validation of user-provided custom codes
- ✅ Duplicate checks against the database
- ✅ Standardized, readable format
- ✅ Integration with Drift ORM

## Code Formats

### Products
**Format**: `PRD-YYYYMMDD-NNNN`

**Examples**:
- `PRD-20260123-0001` - First product on 23/01/2026
- `PRD-20260123-0002` - Second product on 23/01/2026

### Invoices
**Format**: `NF-YYYYMMDD-NNNN`

**Examples**:
- `NF-20260123-0001` - First invoice on 23/01/2026
- `NF-20260123-0002` - Second invoice on 23/01/2026

## How to Use

### 1. Access the Service

The service is registered with **GetIt** (`appInjection`) after `setupAppInjection()` and can be accessed in several ways:

#### Option A: Directly through GetIt
```dart
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/domain/code_generator_service.dart';

final codeGenerator = appInjection.get<CodeGeneratorService>();
```

#### Option B: Through ProductRepository
```dart
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';

final productRepository = appInjection.get<IProductRepository>();

// Generate a code
final code = await productRepository.generateProductCode();

// Validate a custom code
final validationResult = await productRepository.validateProductCode('MEU-CODIGO-001');
```

#### Option C: Through SalesRepository
```dart
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/core/interface/i_sales_repository.dart';

final salesRepository = appInjection.get<ISalesRepository>();

// Generate an invoice number
final invoiceNumberResult = await salesRepository.generateInvoiceNumber();
if (invoiceNumberResult.isSuccessful) {
  print('Número gerado: ${invoiceNumberResult.asSuccess}');
} else {
  print('Erro ao gerar número: ${invoiceNumberResult.asError}');
}

// Validate a custom invoice number
final validationResult = await salesRepository.validateInvoiceNumber('NF-CUSTOM-001');
```

### 2. Generate a Product Code Automatically

```dart
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';

// Through the repository (recommended)
final productRepository = appInjection.get<IProductRepository>();
final code = await productRepository.generateProductCode();

// Create a product with the generated code
final product = Product(
  name: 'Notebook Dell',
  description: 'Notebook Dell Inspiron 15',
  price: 3500.00,
  stockQuantity: 10,
  categoryId: 1,
  code: code,   // Use the generated code
);

await productRepository.saveProduct(product);
```

### 3. Use a Custom Product Code

```dart
final productRepository = appInjection.get<IProductRepository>();

// Code provided by the user
final customCode = 'NOTEBOOK-DELL-001';

// Validate the code before using it
final validation = await productRepository.validateProductCode(customCode);

if (validation.isSuccessful) {
  // The code is valid and can be used
  final product = Product(
    name: 'Notebook Dell',
    description: 'Notebook Dell Inspiron 15',
    price: 3500.00,
    stockQuantity: 10,
    categoryId: 1,
    code: customCode,
  );

  await productRepository.saveProduct(product);
} else {
  // The code is invalid; show an error to the user
  print('Erro: ${validation.asError}');
  // Example: "Código já existe no banco de dados"
}
```

### 4. Generate an Invoice Number Automatically

```dart
final salesRepository = appInjection.get<ISalesRepository>();

// Generate an invoice number automatically
final invoiceNumberResult = await salesRepository.generateInvoiceNumber();
if (invoiceNumberResult.hasError) {
  print('Erro: ${invoiceNumberResult.asError}');
  return;
}
final invoiceNumber = invoiceNumberResult.asSuccess;

// Create an invoice with the generated number
final invoice = Invoice(
  id: -1,
  data: InvoiceData(
    invoiceNumber: invoiceNumber,     // Use the generated number
    customerId: 1,
    customerName: 'João Silva',
    customerCpf: '12345678900',
    items: [
      InvoiceItem(
        productId: 1,
        productCode: 'PRD-20260123-0001',
        productName: 'Notebook Dell',
        quantity: 1,
        unitPrice: 3500.00,
      ),
    ],
    paymentMethod: 'Cartão de Crédito',
  ),
);

await salesRepository.saveSale(invoice);
```

### 5. Use a Custom Invoice Number

```dart
final salesRepository = appInjection.get<ISalesRepository>();

// Number provided by the user
final customNumber = 'NF-VENDA-ESPECIAL-001';

// Validate the number before using it
final validation = await salesRepository.validateInvoiceNumber(customNumber);

if (validation.isSuccessful) {
  // The number is valid and can be used
  final invoice = Invoice(
    id: -1,
    data: InvoiceData(
      invoiceNumber: customNumber,
      customerId: 1,
      customerName: 'João Silva',
      customerCpf: '12345678900',
      items: [
        InvoiceItem(
          productId: 1,
          productCode: 'PRD-20260123-0001',
          productName: 'Notebook Dell',
          quantity: 1,
          unitPrice: 3500.00,
        ),
      ],
      paymentMethod: 'Cartão de Crédito',
    ),
  );

  await salesRepository.saveSale(invoice);
} else {
  // The number is invalid; show an error to the user
  print('Erro: ${validation.asError}');
  // Example: "Número da nota já existe no banco de dados"
}
```

## User Interface (UI) Integration

### Example: Product Registration Screen

```dart
class ProductRegistrationScreen extends StatefulWidget {
  @override
  _ProductRegistrationScreenState createState() =>
      _ProductRegistrationScreenState();
}

class _ProductRegistrationScreenState extends State<ProductRegistrationScreen> {
  final _codeController = TextEditingController();
  final _productRepository = appInjection.get<IProductRepository>();
  bool _useAutoCode = true;

  Future<void> _generateCode() async {
    final code = await _productRepository.generateProductCode();
    setState(() {
      _codeController.text = code;
    });
  }

  Future<void> _saveProduct() async {
    String code;

    if (_useAutoCode) {
      // Use the automatically generated code
      code = await _productRepository.generateProductCode();
    } else {
      // Validate the code provided by the user
      final validation = await _productRepository.validateProductCode(
        _codeController.text,
      );

      if (!validation.isSuccessful) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${validation.asError}')),
        );
        return;
      }

      code = _codeController.text;
    }

    // Create and save the product with the validated code
    final product = Product(
      name: _nameController.text,
      description: _descriptionController.text,
      price: double.parse(_priceController.text),
      stockQuantity: int.parse(_stockController.text),
      categoryId: int.tryParse(_categoryIdController.text),
      code: code,
    );

    await _productRepository.saveProduct(product);

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Produto salvo com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Produto')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Toggle to choose between an automatic or manual code
            SwitchListTile(
              title: Text('Gerar código automaticamente'),
              value: _useAutoCode,
              onChanged: (value) {
                setState(() {
                  _useAutoCode = value;
                  if (value) {
                    _generateCode();
                  } else {
                    _codeController.clear();
                  }
                });
              },
            ),

            // Code field (disabled when automatic generation is enabled)
            TextField(
              controller: _codeController,
              enabled: !_useAutoCode,
              decoration: InputDecoration(
                labelText: 'Código do Produto',
                suffixIcon: _useAutoCode
                  ? Icon(Icons.lock)
                  : IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: _generateCode,
                    ),
              ),
            ),

            // ... other fields ...

            ElevatedButton(
              onPressed: _saveProduct,
              child: Text('Salvar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Validation Rules

### Product Codes

- ✅ **Minimum**: 3 characters
- ✅ **Maximum**: 50 characters
- ✅ **Must not be empty**
- ✅ **Must be unique** in the database

### Invoice Numbers

- ✅ **Minimum**: 3 characters
- ✅ **Maximum**: 50 characters
- ✅ **Must not be empty**
- ✅ **Must be unique** in the database

## Error Messages

### Product Code Validation

| Condition | Message |
|----------|----------|
| Empty code | "Código não pode ser vazio" |
| Code too short | "Código deve ter no mínimo 3 caracteres" |
| Code too long | "Código deve ter no máximo 50 caracteres" |
| Duplicate code | "Código já existe no banco de dados" |
| Valid code | "Código válido" |

### Invoice Number Validation

| Condition | Message |
|----------|----------|
| Empty number | "Número da nota não pode ser vazio" |
| Number too short | "Número da nota deve ter no mínimo 3 caracteres" |
| Number too long | "Número da nota deve ter no máximo 50 caracteres" |
| Duplicate number | "Número da nota já existe no banco de dados" |
| Valid number | "Número da nota válido" |

## Collision Handling

The service implements an automatic collision-resolution mechanism:

1. **Incremental retry**: If a code already exists, the counter is incremented (0001 → 0002 → 0003...)
2. **Safety limit**: After 9999 attempts, a timestamp in milliseconds is added
3. **Database check**: Each code is checked against the database before being returned

## Tests

The service has comprehensive unit-test coverage in `test/code_generator_service_test.dart`:

- ✅ Product code generation
- ✅ Invoice number generation
- ✅ Custom code validation
- ✅ Duplicate checks
- ✅ Collision handling
- ✅ Appropriate error messages

Run the tests with:

```bash
flutter test test/code_generator_service_test.dart
```

## Legacy Code Migration

Products or invoices with codes in the old format continue to work normally. The service only ensures that new codes are unique, regardless of format.

## Performance

- **Code generation**: O(n), where n is the number of collisions (rarely > 1)
- **Validation**: O(1) — a single database query
- **Duplicate check**: O(1) — an indexed database query

The `code` column in `ProductsRecords` has a `UNIQUE` constraint, ensuring database-level integrity.

## Support

For questions or issues, see:
- Source code: `lib/domain/code_generator_service.dart`
- Dependency injection: `lib/application/app_injection.dart`
- Tests: `test/code_generator_service_test.dart`
- Repositories: `lib/domain/repository/product_repository.dart` and `lib/domain/repository/sales_repository.dart`
