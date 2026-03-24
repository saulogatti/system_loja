import 'dart:io';
import 'dart:math';

import 'package:sqlite3/sqlite3.dart';

Future<void> main(List<String> args) async {
  final options = SeedOptions.fromArgs(args);
  final dbFile = File(options.databaseFilePath);
  await dbFile.parent.create(recursive: true);
  final database = sqlite3.open(dbFile.path);

  try {
    database.execute('PRAGMA foreign_keys = ON;');
    _ensureSchema(database);

    if (options.reset) {
      _clearTables(database);
    }

    final summary = _seedDatabase(database, options);

    stdout.writeln('Seed finalizado com sucesso.');
    stdout.writeln('Arquivo do banco: ${dbFile.path}');
    stdout.writeln('Categorias inseridas: ${summary.categories}');
    stdout.writeln('Empresas inseridas: ${summary.companies}');
    stdout.writeln('Clientes inseridos: ${summary.customers}');
    stdout.writeln('Produtos inseridos: ${summary.products}');
    stdout.writeln('Notas inseridas: ${summary.invoices}');
    stdout.writeln('Itens de nota inseridos: ${summary.invoiceItems}');
  } finally {
    database.dispose();
  }
}

void _clearTables(Database database) {
  database.execute('BEGIN;');
  try {
    database.execute('DELETE FROM invoice_items_records;');
    database.execute('DELETE FROM invoices_records;');
    database.execute('DELETE FROM products_records;');
    database.execute('DELETE FROM customer_records;');
    database.execute('DELETE FROM company_records;');
    database.execute('DELETE FROM categories_records;');
    database.execute('DELETE FROM address_records;');

    // Reinicia o autoincrement para facilitar cenarios de teste deterministas.
    database.execute('DELETE FROM sqlite_sequence;');
    database.execute('COMMIT;');
  } catch (_) {
    database.execute('ROLLBACK;');
    rethrow;
  }
}

void _ensureSchema(Database database) {
  database.execute('''
CREATE TABLE IF NOT EXISTS categories_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  registration_date TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_updated_date TEXT
);
''');

  database.execute('''
CREATE TABLE IF NOT EXISTS company_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  cnpj TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  email TEXT,
  address TEXT,
  registration_date TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_updated_date TEXT
);
''');

  database.execute('''
CREATE TABLE IF NOT EXISTS customer_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  cpf TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  address TEXT,
  registration_date TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_updated_date TEXT
);
''');

  database.execute('''
CREATE TABLE IF NOT EXISTS products_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  code TEXT NOT NULL UNIQUE,
  category_id INTEGER,
  description TEXT NOT NULL,
  name TEXT NOT NULL,
  price REAL NOT NULL,
  stock_quantity INTEGER NOT NULL,
  registration_date TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_updated_date TEXT,
  FOREIGN KEY (category_id) REFERENCES categories_records(id)
);
''');

  database.execute('''
CREATE TABLE IF NOT EXISTS invoices_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  company_cnpj TEXT,
  company_id INTEGER,
  company_name TEXT,
  customer_cpf TEXT,
  customer_id INTEGER,
  customer_name TEXT,
  invoice_number TEXT NOT NULL UNIQUE,
  issue_date TEXT NOT NULL,
  last_updated_date TEXT,
  payment_method TEXT NOT NULL,
  registration_date TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  total_value REAL NOT NULL,
  type TEXT NOT NULL DEFAULT 'exit'
);
''');

  database.execute('''
CREATE TABLE IF NOT EXISTS invoice_items_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nota_id INTEGER NOT NULL,
  produto_id INTEGER NOT NULL,
  produto_nome TEXT NOT NULL,
  produto_codigo TEXT NOT NULL,
  quantidade INTEGER NOT NULL,
  preco_unitario REAL NOT NULL,
  valor_total REAL NOT NULL,
  FOREIGN KEY (nota_id) REFERENCES invoices_records(id)
);
''');

  database.execute('''
CREATE TABLE IF NOT EXISTS address_records (
  city TEXT NOT NULL,
  last_updated_date TEXT,
  neighborhood TEXT NOT NULL,
  state TEXT NOT NULL,
  street TEXT NOT NULL,
  zip_code TEXT NOT NULL
);
''');
}

String _numericCode({required int length, required int value}) {
  return value.toString().padLeft(length, '0');
}

List<SeedProduct> _pickProducts({
  required List<SeedProduct> products,
  required Random random,
  required int quantity,
}) {
  final copy = [...products]..shuffle(random);
  return copy.take(quantity).toList();
}

SeedSummary _seedDatabase(Database database, SeedOptions options) {
  final random = Random(options.randomSeed);
  final now = DateTime.now();
  final nowIso = now.toIso8601String();

  final categoryIds = <int>[];
  final companyIds = <int>[];
  final customerIds = <int>[];
  final products = <SeedProduct>[];
  var invoiceItemsCount = 0;

  database.execute('BEGIN;');
  try {
    final insertCategory = database.prepare('''
INSERT INTO categories_records (name, description, registration_date, last_updated_date)
VALUES (?, ?, ?, ?);
''');

    final insertCompany = database.prepare('''
INSERT INTO company_records (cnpj, name, email, address, registration_date, last_updated_date)
VALUES (?, ?, ?, ?, ?, ?);
''');

    final insertCustomer = database.prepare('''
INSERT INTO customer_records (cpf, name, email, phone, address, registration_date, last_updated_date)
VALUES (?, ?, ?, ?, ?, ?, ?);
''');

    final insertProduct = database.prepare('''
INSERT INTO products_records (code, category_id, description, name, price, stock_quantity, registration_date, last_updated_date)
VALUES (?, ?, ?, ?, ?, ?, ?, ?);
''');

    final insertInvoice = database.prepare('''
INSERT INTO invoices_records (
  company_cnpj, company_id, company_name,
  customer_cpf, customer_id, customer_name,
  invoice_number, issue_date, last_updated_date,
  payment_method, registration_date, total_value, type
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
''');

    final insertInvoiceItem = database.prepare('''
INSERT INTO invoice_items_records (
  nota_id, produto_id, produto_nome, produto_codigo,
  quantidade, preco_unitario, valor_total
) VALUES (?, ?, ?, ?, ?, ?, ?);
''');

    for (var i = 0; i < options.categoryCount; i++) {
      insertCategory.execute([
        'Categoria ${i + 1}',
        'Categoria de teste ${i + 1}',
        now.subtract(Duration(days: i)).toIso8601String(),
        nowIso,
      ]);
      final id = database.lastInsertRowId;
      categoryIds.add(id);
    }

    for (var i = 0; i < options.companyCount; i++) {
      final cnpj = _numericCode(length: 14, value: i + 1);
      final addressJson =
          '{"street":"Rua Empresa ${i + 1}","zipCode":"01001000","neighborhood":"Centro","city":"Sao Paulo","state":"SP"}';
      insertCompany.execute([
        cnpj,
        'Empresa Teste ${i + 1}',
        'empresa${i + 1}@teste.local',
        addressJson,
        now.subtract(Duration(days: 30 + i)).toIso8601String(),
        nowIso,
      ]);
      final id = database.lastInsertRowId;
      companyIds.add(id);
    }

    for (var i = 0; i < options.customerCount; i++) {
      final cpf = _numericCode(length: 11, value: i + 1);
      final addressJson =
          '{"street":"Rua Cliente ${i + 1}","zipCode":"02002000","neighborhood":"Bairro ${((i % 5) + 1)}","city":"Sao Paulo","state":"SP"}';
      insertCustomer.execute([
        cpf,
        'Cliente Teste ${i + 1}',
        'cliente${i + 1}@teste.local',
        '119${_numericCode(length: 8, value: i + 1)}',
        addressJson,
        now.subtract(Duration(days: 20 + i)).toIso8601String(),
        nowIso,
      ]);
      final id = database.lastInsertRowId;
      customerIds.add(id);
    }

    for (var i = 0; i < options.productCount; i++) {
      final categoryId = categoryIds[i % categoryIds.length];
      final price = 8.0 + (i * 3.75);
      final code = 'PRD-${_numericCode(length: 5, value: i + 1)}';
      final name = 'Produto Teste ${i + 1}';
      insertProduct.execute([
        code,
        categoryId,
        'Produto de teste para cenarios automatizados',
        name,
        price,
        100 + (i * 3),
        now.subtract(Duration(days: i)).toIso8601String(),
        nowIso,
      ]);
      final id = database.lastInsertRowId;
      products.add(SeedProduct(id: id, code: code, name: name, price: price));
    }

    for (var i = 0; i < options.invoiceCount; i++) {
      final isExitInvoice = i.isEven;
      final issueDate = now.subtract(Duration(days: i % 30));
      final selectedProducts = _pickProducts(
        products: products,
        random: random,
        quantity: 1 + random.nextInt(3),
      );

      final items = selectedProducts
          .map((product) => SeedInvoiceItem(product: product, quantity: 1 + random.nextInt(4)))
          .toList();

      final totalValue = items.fold<double>(0, (sum, item) => sum + item.totalValue);

      final customerId = isExitInvoice ? customerIds[i % customerIds.length] : null;
      final companyId = isExitInvoice ? null : companyIds[i % companyIds.length];

      final customerName = customerId == null ? null : 'Cliente Teste ${(i % customerIds.length) + 1}';
      final customerCpf = customerId == null
          ? null
          : _numericCode(length: 11, value: (i % customerIds.length) + 1);

      final companyName = companyId == null ? null : 'Empresa Teste ${(i % companyIds.length) + 1}';
      final companyCnpj = companyId == null
          ? null
          : _numericCode(length: 14, value: (i % companyIds.length) + 1);

      insertInvoice.execute([
        companyCnpj,
        companyId,
        companyName,
        customerCpf,
        customerId,
        customerName,
        'NF-${now.year}-${_numericCode(length: 6, value: i + 1)}',
        issueDate.toIso8601String(),
        nowIso,
        isExitInvoice ? 'PIX' : 'Boleto',
        nowIso,
        totalValue,
        isExitInvoice ? 'exit' : 'entry',
      ]);
      final invoiceId = database.lastInsertRowId;

      for (final item in items) {
        insertInvoiceItem.execute([
          invoiceId,
          item.product.id,
          item.product.name,
          item.product.code,
          item.quantity,
          item.product.price,
          item.totalValue,
        ]);
        invoiceItemsCount++;
      }
    }

    insertCategory.dispose();
    insertCompany.dispose();
    insertCustomer.dispose();
    insertProduct.dispose();
    insertInvoice.dispose();
    insertInvoiceItem.dispose();
    database.execute('COMMIT;');
  } catch (_) {
    database.execute('ROLLBACK;');
    rethrow;
  }

  return SeedSummary(
    categories: categoryIds.length,
    companies: companyIds.length,
    customers: customerIds.length,
    products: products.length,
    invoices: options.invoiceCount,
    invoiceItems: invoiceItemsCount,
  );
}

class SeedInvoiceItem {
  final SeedProduct product;
  final int quantity;

  const SeedInvoiceItem({required this.product, required this.quantity});

  double get totalValue => product.price * quantity;
}

class SeedOptions {
  final bool reset;
  final int categoryCount;
  final int companyCount;
  final int customerCount;
  final int productCount;
  final int invoiceCount;
  final int randomSeed;
  final String databaseFilePath;

  const SeedOptions({
    required this.reset,
    required this.categoryCount,
    required this.companyCount,
    required this.customerCount,
    required this.productCount,
    required this.invoiceCount,
    required this.randomSeed,
    required this.databaseFilePath,
  });

  factory SeedOptions.fromArgs(List<String> args) {
    final values = <String, String>{};
    var reset = false;

    for (final arg in args) {
      if (arg == '--reset') {
        reset = true;
        continue;
      }
      if (arg.startsWith('--') && arg.contains('=')) {
        final index = arg.indexOf('=');
        final key = arg.substring(2, index);
        final value = arg.substring(index + 1);
        values[key] = value;
      }
    }

    return SeedOptions(
      reset: reset,
      categoryCount: _parsePositive(values['categories'], fallback: 5),
      companyCount: _parsePositive(values['companies'], fallback: 6),
      customerCount: _parsePositive(values['customers'], fallback: 12),
      productCount: _parsePositive(values['products'], fallback: 30),
      invoiceCount: _parsePositive(values['invoices'], fallback: 24),
      randomSeed: _parsePositive(values['seed'], fallback: 42),
      databaseFilePath:
          values['dbFile'] ??
          '${Directory.current.path}${Platform.pathSeparator}.seed_db${Platform.pathSeparator}system_loja.sqlite',
    );
  }

  static int _parsePositive(String? input, {required int fallback}) {
    final parsed = int.tryParse(input ?? '');
    if (parsed == null || parsed <= 0) {
      return fallback;
    }
    return parsed;
  }
}

class SeedProduct {
  final int id;
  final String code;
  final String name;
  final double price;

  const SeedProduct({required this.id, required this.code, required this.name, required this.price});
}

class SeedSummary {
  final int categories;
  final int companies;
  final int customers;
  final int products;
  final int invoices;
  final int invoiceItems;

  const SeedSummary({
    required this.categories,
    required this.companies,
    required this.customers,
    required this.products,
    required this.invoices,
    required this.invoiceItems,
  });
}
