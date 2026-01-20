# Drift Database Migration - Implementation Summary

## ✅ Completed Changes

### 1. Customer (Cliente) Entity - Improved
**Files Modified:**
- `lib/data/database/table/clientes_records.dart` - Reorganized column order for consistency
- `lib/data/database/cliente_dao.dart` - Updated to work with Customer domain model instead of raw records
- `lib/data/database/extension/cliente_to_companion.dart` - Enhanced with support for both insert and update operations

**Key Improvements:**
- ClienteDao now returns `Customer` objects (domain model) instead of `ClientesRecord`
- Added `forUpdate` parameter to handle insert vs update scenarios properly
- All CRUD operations maintain proper type safety and domain separation

### 2. Invoice (Nota) Entity - NEW ✨
**Files Created:**
- `lib/data/database/table/invoices_records.dart` - Drift table definition
- `lib/data/database/invoice_dao.dart` - DAO with full CRUD operations
- `lib/data/database/invoice_dao.g.dart` - Generated code (placeholder)
- `lib/data/database/extension/invoice_to_companion.dart` - Domain/Drift conversions (includes Invoice and InvoiceItem)

**Features:**
- Complete CRUD operations for Invoice entities
- Transaction support with `insertInvoiceWithItems()` and `updateInvoiceWithItems()`
- Automatic loading of invoice items when fetching invoices
- Proper denormalization of customer data for query performance

### 3. InvoiceItem Entity - NEW ✨
**Files Created:**
- `lib/data/database/table/invoice_items_records.dart` - Drift table definition
- `lib/data/database/invoice_item_dao.dart` - DAO with CRUD operations
- `lib/data/database/invoice_item_dao.g.dart` - Generated code (placeholder)

**Features:**
- CRUD operations for invoice items
- Support for querying items by invoice ID
- Bulk delete support for updating invoice items
- Proper denormalization of product data

### 4. Database Configuration
**Files Modified:**
- `lib/data/database/app_database.dart` - Updated to include all entities and DAOs
  - Added `InvoicesRecords` and `InvoiceItemsRecords` tables
  - Added `InvoiceDao` and `InvoiceItemDao` DAOs
  - Bumped schema version from 1 to 2

## 🔧 Required Action: Run Build Runner

The Drift code generator needs to be run to complete the migration:

```bash
dart run build_runner build --delete-conflicting-outputs
```

This will:
1. Regenerate `app_database.g.dart` with the new table definitions
2. Update all DAO mixin files with proper table accessors
3. Generate type-safe query builders for the new tables

## 📊 Database Schema

### Clientes (Customers)
- `id` (PK, auto-increment)
- `name`, `cpf` (unique), `email`, `phone`, `address`
- `registration_date` (default: current timestamp)
- `last_updated_date` (nullable)

### Products
- `id` (PK, auto-increment)
- `name`, `code`, `description`, `category`
- `price`, `stock_quantity`
- `registration_date` (default: current timestamp)
- `last_updated_date` (nullable)

### Invoices (Notas Fiscais)
- `id` (PK, auto-increment)
- `invoice_number` (numero_nota)
- `customer_id` (cliente_id)
- `customer_name`, `customer_cpf` (denormalized)
- `total_value` (valor_total)
- `payment_method` (forma_pagamento)
- `issue_date` (data_emissao)
- `registration_date`, `last_updated_date`

### Invoice Items (Itens de Nota Fiscal)
- `id` (PK, auto-increment)
- `invoice_id` (nota_id, FK to invoices)
- `product_id` (produto_id)
- `product_name`, `product_code` (denormalized)
- `quantity` (quantidade)
- `unit_price` (preco_unitario)
- `total_value` (valor_total)

## 🎯 Architecture Pattern Used

All entities follow the **Customer Pattern** as requested:

1. **Drift Tables** (`*_records.dart`): Define database schema
2. **DAOs** (`*_dao.dart`): Handle database operations
3. **Domain Models** (`lib/core/models/*.dart`): Business logic objects
4. **Extensions** (`extension/*_to_companion.dart`): Convert between Drift and domain models

### Pattern Benefits:
- ✅ Separation of concerns (database vs business logic)
- ✅ Type-safe operations with compile-time checks
- ✅ Easy to test (mock DAOs independently)
- ✅ Clean domain models without database dependencies

## 💡 Usage Examples

### Customer Operations
```dart
final db = AppDatabase();
final customerDao = db.clienteDao;

// Insert
final customer = Customer(id: 0, name: 'João', cpf: '12345678900', ...);
final id = await customerDao.insertCliente(customer);

// Get all
final customers = await customerDao.getAll(); // Returns List<Customer>

// Get by ID
final customer = await customerDao.getById(1); // Returns Customer?

// Update
customer.lastUpdatedDate = DateTime.now();
await customerDao.updateCliente(customer);

// Delete
await customerDao.deleteCliente(1);
```

### Invoice Operations with Items
```dart
final invoiceDao = db.invoiceDao;

// Create invoice with items (transactional)
final invoice = Invoice(
  id: 0,
  data: InvoiceData(
    invoiceNumber: 'NF-001',
    customerId: 1,
    customerName: 'João',
    customerCpf: '12345678900',
    items: [
      InvoiceItem(
        productId: 1,
        productName: 'Product A',
        productCode: 'PA001',
        quantity: 2,
        unitPrice: 10.0,
      ),
    ],
    paymentMethod: 'Cartão',
  ),
);

final invoiceId = await invoiceDao.insertInvoiceWithItems(invoice);

// Get invoice with items loaded
final loadedInvoice = await invoiceDao.getById(invoiceId);
print('Total: ${loadedInvoice?.data.totalValue}');
print('Items: ${loadedInvoice?.data.items.length}');

// Update invoice and items (transactional)
await invoiceDao.updateInvoiceWithItems(invoice);
```

## 🧪 Testing

After running build_runner, you can test the implementation:

1. **Verify compilation**: `dart analyze` or build your app
2. **Run existing tests**: Check if database tests pass
3. **Manual testing**: Create test cases for new entities

## 📝 Next Steps

1. ✅ Run `dart run build_runner build --delete-conflicting-outputs`
2. ⚠️ Review generated code in `app_database.g.dart`
3. 🧪 Test CRUD operations for all entities
4. 🔄 Update any existing managers that used legacy SQLite approach
5. 📚 Consider adding migration strategy if needed (schema v1 → v2)

## ⚙️ Migration Notes

- **Schema Version**: Updated from 1 to 2
- **Legacy Data**: No migration strategy implemented (as per requirements - software in development)
- **Breaking Changes**: ClienteDao API changed to return Customer objects instead of ClientesRecord

## 🆘 Troubleshooting

### Build runner fails
```bash
# Clean build cache
flutter pub run build_runner clean
# Rebuild
flutter pub run build_runner build --delete-conflicting-outputs
```

### Compilation errors after generation
- Ensure all imports are correct
- Check that domain models (`Customer`, `Invoice`, `InvoiceItem`) match table definitions
- Verify extension methods are properly imported in DAOs

### Database version conflicts
- If app was already installed, uninstall it to get fresh database
- Or implement a proper migration in `onUpgrade` callback

---

**Migration Status**: ✅ Complete (pending build_runner execution)
**Schema Version**: 2
**Entities Migrated**: Customer ✅ | Product ✅ | Invoice ✅ | InvoiceItem ✅
