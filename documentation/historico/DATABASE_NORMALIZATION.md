# SQL Database Normalization

## Identified Problem

In earlier database versions (v1), the `notas_fiscais` and `itens_nota_fiscal` tables contained denormalized fields:

- **Table `notas_fiscais`**: `cliente_nome`, `cliente_cpf`
- **Table `itens_nota_fiscal`**: `produto_nome`, `produto_codigo`

### Risk of Inconsistency

These denormalized fields introduced a risk of data inconsistency:

1. If a customer's name or CPF was updated through `ClienteSqlManager`, existing invoices for that customer would contain stale data.
2. If a product's name or code was updated through `ProdutoSqlManager`, existing invoice items would contain stale data.

## Implemented Solution

### Database Version 2

In version 2, the denormalized fields were removed and queries using JOINs were implemented to ensure data integrity.

#### Schema Changes

**`notas_fiscais` table (v2)**
```sql
CREATE TABLE notas_fiscais (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  numero_nota TEXT NOT NULL UNIQUE,
  cliente_id INTEGER NOT NULL,              -- Retained
  -- cliente_nome TEXT NOT NULL,            -- REMOVED
  -- cliente_cpf TEXT NOT NULL,             -- REMOVED
  valor_total REAL NOT NULL,
  forma_pagamento TEXT NOT NULL,
  data_emissao TEXT NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
)
```

**`itens_nota_fiscal` table (v2)**
```sql
CREATE TABLE itens_nota_fiscal (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nota_fiscal_id INTEGER NOT NULL,
  produto_id INTEGER NOT NULL,              -- Retained
  -- produto_nome TEXT NOT NULL,            -- REMOVED
  -- produto_codigo TEXT NOT NULL,          -- REMOVED
  quantidade INTEGER NOT NULL,
  preco_unitario REAL NOT NULL,
  valor_total REAL NOT NULL,
  FOREIGN KEY (nota_fiscal_id) REFERENCES notas_fiscais(id) ON DELETE CASCADE,
  FOREIGN KEY (produto_id) REFERENCES produtos(id)
)
```

#### Using JOINs

All invoice queries now use JOINs to retrieve current customer and product data:

```sql
-- Example invoice query
SELECT 
  nf.*, 
  c.nome as cliente_nome, 
  c.cpf as cliente_cpf
FROM notas_fiscais nf
INNER JOIN clientes c ON nf.cliente_id = c.id
WHERE nf.id = ?

-- Example invoice-item query
SELECT 
  i.*, 
  p.nome as produto_nome, 
  p.codigo as produto_codigo
FROM itens_nota_fiscal i
INNER JOIN produtos p ON i.produto_id = p.id
WHERE i.nota_fiscal_id = ?
```

### Automatic Migration

The system automatically migrates data from version 1 to version 2:

1. Creates temporary tables with the new structure (without denormalized fields).
2. Copies the relevant data from the old tables.
3. Deletes the old tables.
4. Renames the temporary tables.

The migration runs automatically when the database is opened and its version is detected as earlier than 2.

## Benefits

### 1. Data Integrity

When a customer or product is updated, all invoices now automatically reflect the latest data through JOINs.

### 2. Guaranteed Consistency

Invoices no longer risk containing stale data because values are always retrieved from the original tables.

### 3. Simplified Maintenance

There is no need for complex logic to propagate customer and product updates to every related invoice.

### 4. Database Standards

The solution follows database normalization best practices, retaining foreign keys and using JOINs for relationships.

## Integrity Tests

Comprehensive tests in `test/data_integrity_test.dart` validate:

1. Customer name changes are reflected in invoices.
2. Customer CPF changes are reflected in invoices.
3. Product name changes are reflected in invoice items.
4. Product code changes are reflected in invoice items.
5. Updated data is consistent across all query methods (by ID, number, customer, period, and full list).

## Impact on Existing Systems

### Model Compatibility

The data models (`NotaFiscal`, `ItemNotaFiscal`) retain denormalized fields for compatibility with JSON persistence. `NotaFiscalSqlManager` populates these fields dynamically through JOINs.

### No UI Impact

Screens and UI components do not need changes because they continue receiving complete `NotaFiscal` objects with all fields populated.

### Transparent Migration

Existing users' databases are migrated automatically the next time the app starts, without data loss.

## References

- [GitHub Issue #11 - Discussion r2573166765](https://github.com/saulogatti/system_loja/pull/11#discussion_r2573166765)
- Implementation: `lib/data/database/database_scripts.dart`
- Migration: `lib/data/database/database_helper.dart`
- Manager: `lib/data/database/nota_fiscal_sql_manager.dart`
- Tests: `test/data_integrity_test.dart`
