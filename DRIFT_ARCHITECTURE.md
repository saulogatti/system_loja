# Drift Database Architecture

## 📁 File Structure

```
lib/data/database/
├── app_database.dart              # Main database configuration
├── app_database.g.dart            # Generated: table implementations
│
├── table/                         # Table definitions (schema)
│   ├── clientes_records.dart     # Customer table
│   ├── products_records.dart     # Product table
│   ├── invoices_records.dart     # Invoice table
│   └── invoice_items_records.dart # Invoice items table
│
├── extension/                     # Domain ↔ Drift converters
│   ├── cliente_to_companion.dart # Customer conversions
│   └── invoice_to_companion.dart # Invoice & InvoiceItem conversions
│
└── *_dao.dart                     # Data Access Objects
    ├── cliente_dao.dart           # Customer CRUD
    ├── product_dao.dart           # Product CRUD
    ├── invoice_dao.dart           # Invoice CRUD (with transactions)
    └── invoice_item_dao.dart      # Invoice item CRUD
```

## 🔄 Data Flow

```
┌─────────────────┐
│  Domain Models  │  (Customer, Invoice, Product)
│  lib/core/      │  Pure business logic
└────────┬────────┘
         │ uses
         ▼
┌─────────────────┐
│   Extensions    │  toCompanion() / toDomain()
│  lib/data/      │  Type conversions
│  database/      │
│  extension/     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│      DAOs       │  CRUD operations
│   *_dao.dart    │  Query builders
└────────┬────────┘
         │ operates on
         ▼
┌─────────────────┐
│  Drift Tables   │  Table definitions
│  table/*.dart   │  Column types & constraints
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   AppDatabase   │  Coordination layer
│app_database.dart│  Schema version, migrations
└─────────────────┘
```

## 🎯 Key Patterns

### 1. Repository Pattern
Each entity has a DAO that acts as a repository:
```dart
class ClienteDao {
  Future<List<Customer>> getAll() { ... }
  Future<Customer?> getById(int id) { ... }
  Future<int> insertCliente(Customer customer) { ... }
  Future<int> updateCliente(Customer customer) { ... }
  Future<int> deleteCliente(int id) { ... }
}
```

### 2. Domain Separation
- **Domain Models** (`Customer`, `Invoice`): No database dependencies
- **Drift Records** (`ClientesRecord`): Generated database types
- **Extensions**: Bridge between the two

### 3. Transaction Support
Complex operations use transactions:
```dart
Future<int> insertInvoiceWithItems(Invoice invoice) async {
  return await transaction(() async {
    final invoiceId = await insertInvoice(invoice);
    for (final item in invoice.data.items) {
      await invoiceItemDao.insertInvoiceItem(item, invoiceId: invoiceId);
    }
    return invoiceId;
  });
}
```

### 4. Denormalization for Performance
Foreign key data is denormalized:
- `InvoicesRecords` stores `customer_name` and `customer_cpf`
- `InvoiceItemsRecords` stores `product_name` and `product_code`

This avoids joins in common queries while maintaining referential integrity via IDs.

## 📊 Entity Relationships

```
┌─────────────┐
│  Customer   │
│  (Cliente)  │
└──────┬──────┘
       │ 1
       │
       │ N
       ▼
┌─────────────┐
│   Invoice   │──┐
│   (Nota)    │  │ 1
└─────────────┘  │
                 │ N
                 ▼
            ┌────────────────┐
            │  InvoiceItem   │──┐
            │ (Item da Nota) │  │ N
            └────────────────┘  │
                                │ 1
                                ▼
                           ┌─────────┐
                           │ Product │
                           └─────────┘
```

## 🔧 Schema Version: 2

### Version 1 (Initial)
- Customers (clientes_records)
- Products (products_records)

### Version 2 (Current)
- Added: Invoices (invoices_records)
- Added: Invoice Items (invoice_items_records)

## 💡 Best Practices

### When to Use Extensions
- Always use `toCompanion()` when inserting/updating
- Always use `toDomain()` when reading from database
- Keep extensions pure (no business logic)

### Transaction Guidelines
- Use for multi-table operations (invoice + items)
- Use for operations that must be atomic
- Avoid for single-table operations

### Error Handling
```dart
try {
  final id = await dao.insertCliente(customer);
  print('Inserted with ID: $id');
} on SqliteException catch (e) {
  if (e.extendedResultCode == 2067) {
    // UNIQUE constraint failed
    print('CPF already exists');
  }
}
```

## 🚀 Next Steps After Build Runner

1. **Test Individual DAOs**
   ```dart
   final db = AppDatabase();
   final customer = await db.clienteDao.getAll();
   ```

2. **Test Relationships**
   ```dart
   final invoice = await db.invoiceDao.getById(1);
   print('Invoice has ${invoice?.data.items.length} items');
   ```

3. **Test Transactions**
   ```dart
   final id = await db.invoiceDao.insertInvoiceWithItems(invoice);
   ```

4. **Integration Tests**
   - Create test suite for each DAO
   - Test error conditions (unique constraints, etc.)
   - Test transaction rollback scenarios

---

**Status**: ✅ Implementation complete  
**Pending**: Build runner execution  
**Schema**: Version 2
