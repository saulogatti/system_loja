# Drift Database Architecture

## 📁 File Structure

```
lib/data/database/
├── app_database.dart              # AppDatabase, migrações, schemaVersion
├── app_database.g.dart            # Gerado (Drift)
├── system_database.dart           # Banco de sistema (logs, users, config)
│
├── table/                         # Definições de tabela (schema)
│   ├── customer_records.dart, products_records.dart, categories_records.dart
│   ├── company_records.dart, address_records.dart
│   ├── invoices_records.dart, invoice_items_records.dart
│   └── system/                    # Tabelas do SystemDatabase
│
├── mapper/                        # XxxRecord → modelos em lib/core/models/
├── extension/                     # Domínio ↔ Companions (insert/update)
│
└── dao/                           # Data Access Objects (*_dao.dart)
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

### 1. Repository + DAO
A **UI** fala com **interfaces** em `lib/core/interface/`; as **implementações** em `lib/domain/repository/` orquestram **DAOs** em `lib/data/database/dao/` (operações atômicas / queries). Transações que cruzam regras de negócio (ex.: nota + itens + estoque) ficam no repositório de domínio, não no DAO.
```dart
// Exemplo ilustrativo — DAO focado em persistência
class CustomerDao {
  Future<List<CustomerRecord>> getAllRows() { ... }
  Future<int> insertRow(CustomersRecordsCompanion row) { ... }
}
```

### 2. Domain Separation
- **Domain Models** (`Customer`, `Invoice`, … em `lib/core/models/`): sem dependência de Drift
- **Drift Records** (`XxxRecord`): tipos gerados pelas tabelas — **não** usar `@UseRowClass` com entidades de domínio
- **Mappers + extensions**: conversão entre registro Drift e domínio / companions

### 3. Transaction Support
Operações compostas usam `transaction` no **repositório** (ex.: `SalesRepository`), chamando métodos atômicos dos DAOs (`insertInvoice`, itens, atualização de estoque).

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
