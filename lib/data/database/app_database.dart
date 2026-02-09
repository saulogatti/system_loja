import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:system_loja/core/managers/system_error_manager.dart';
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/category.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/data/database/dao/address_dao.dart';
import 'package:system_loja/data/database/dao/category_dao.dart';
import 'package:system_loja/data/database/dao/company_dao.dart';
import 'package:system_loja/data/database/dao/customer_dao.dart';
import 'package:system_loja/data/database/dao/invoice_dao.dart';
import 'package:system_loja/data/database/dao/invoice_item_dao.dart';
import 'package:system_loja/data/database/dao/product_dao.dart';
import 'package:system_loja/data/database/extension/customer_to_companion.dart';
import 'package:system_loja/data/database/table/address_records.dart';
import 'package:system_loja/data/database/table/categories_records.dart';
import 'package:system_loja/data/database/table/company_records.dart';
import 'package:system_loja/data/database/table/customer_records.dart';
import 'package:system_loja/data/database/table/invoice_items_records.dart';
import 'package:system_loja/data/database/table/invoices_records.dart';
import 'package:system_loja/data/database/table/products_records.dart';

part 'app_database.g.dart';

/// Banco de dados principal da aplicação usando Drift.
///
/// Gerencia todas as tabelas e DAOs do sistema de loja.
@DriftDatabase(
  tables: [
    CategoriesRecords,
    CompanyRecords,
    CustomerRecords,
    ProductsRecords,
    InvoicesRecords,
    InvoiceItemsRecords,
    AddressRecords,
  ],
  daos: [
    CategoryDao,
    CompanyDao,
    CustomerDao,
    ProductDao,
    InvoiceDao,
    InvoiceItemDao,
    AddressDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  static final _nameBd = 'system_loja';

  AppDatabase() : super(_openConnection(getApplicationSupportDirectory));

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) => m.createAll(),
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 3) {
        // Criar tabela de categorias
        await m.createTable(categoriesRecords);

        // Adicionar coluna categoryId à tabela products
        await m.addColumn(productsRecords, productsRecords.categoryId);

        // Migrar categorias existentes dos produtos para a nova tabela
        await _migrateCategoriesFromProducts();
      } else if (from < 8) {
        // Criar tabela de clientes, ele cria automaticamente a partir do modelo
        await m.createAll();
        // Migrar dados da tabela ClientesRecords para CustomerRecords
        await _migrateClientesToCustomers();
      }
      if (from < 9) {
        // Criar tabela de empresas
        await m.createTable(companyRecords);
      }
      if (from < 10) {
        // Criar tabela de endereços
        await m.createAll();
        await _migrateAddressesFromCompaniesAndCustomers();
      }
    },
  );
  @override
  int get schemaVersion => 10;
  // Dentro da sua classe de banco (Database)
  /// Cria um backup manual do banco de dados usando o comando `VACUUM INTO`.
  ///
  /// Escapa aspas simples no [backupFile] para evitar erros de SQL e reduzir
  /// a superfície de injeção caso o caminho não seja totalmente confiável.
  Future<void> manualBackup(String backupFile) async {
    final sanitizedBackupFile = backupFile.replaceAll("'", "''");

    // O comando VACUUM INTO cria um backup consistente "a quente"
    await customStatement("VACUUM INTO '$sanitizedBackupFile'");
  }

  /// Migrar Endereços de Empresas e Clientes para AddressRecords
  Future<void> _migrateAddressesFromCompaniesAndCustomers() async {
    final companyRows = await companyRecords.select().get();
    final customerRows = await customerRecords.select().get();
    for (final company in companyRows) {
      await into(addressRecords).insert(company.address.toCompanion());
    }
    for (final customer in customerRows) {
      await into(addressRecords).insert(customer.address.toCompanion());
    }
  }

  /// Migra categorias existentes dos produtos para a tabela categories_records.
  ///
  /// Este método é executado durante a migração do schema version 2 para 3.
  /// Extrai categorias únicas dos produtos e as insere na nova tabela,
  /// depois atualiza os produtos para referenciar os IDs das categorias.
  Future<void> _migrateCategoriesFromProducts() async {
    // Nota: Como a coluna antiga 'category' foi removida, não podemos migrá-la.
    // Os produtos novos precisarão ter categorias atribuídas manualmente.
    // Podemos criar uma categoria padrão para produtos sem categoria.
    await into(categoriesRecords).insert(
      CategoriesRecordsCompanion.insert(
        name: 'Sem Categoria',
        description: const Value('Categoria padrão para produtos migrados'),
      ),
    );

    // Não é necessário atualizar produtos pois categoryId já será null por padrão
  }

  /// Migrar ClientesRecords para CustomerRecords
  Future<void> _migrateClientesToCustomers() async {
    try {
      final clienteRows = await customSelect(
        'SELECT id, name, cpf, email, phone, address, registration_date, last_updated_date FROM clientes_records',
      ).get();

      for (final row in clienteRows) {
        final customer = Customer(
          id: row.data['id'] as int,
          name: row.data['name'] as String,
          cpf: row.data['cpf'] as String,
          email: row.data['email'] as String?,
          phone: row.data['phone'] as String?,
          address: Address(
            street: row.data['street'] as String? ?? '',
            zipCode: row.data['zip_code'] as String? ?? '',
            neighborhood: row.data['neighborhood'] as String? ?? '',
            city: row.data['city'] as String? ?? '',
            state: row.data['state'] as String? ?? '',
          ),
          registrationDate: (row.data['registration_date'] as int) != 0
              ? DateTime.fromMillisecondsSinceEpoch(
                  (row.data['registration_date'] as int) * 1000,
                )
              : DateTime.now(),
          lastUpdatedDate: (row.data['last_updated_date'] as int?) != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  (row.data['last_updated_date'] as int) * 1000,
                )
              : null,
        );

        await into(customerRecords).insert(customer.toCompanion());
      }
      // Após a migração, você pode optar por remover a tabela ClientesRecords
      await customStatement('DROP TABLE IF EXISTS clientes_records;');
    } catch (e, stackTrace) {
      reportError(e, stackTrace);
      // Trate erros de migração aqui, se necessário
    }
  }

  static QueryExecutor _openConnection(
    Future<Object> Function()? applicationSupportDirectory,
  ) {
    return driftDatabase(
      name: _nameBd,
      native: DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: applicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
 
}

extension on Address {
  Insertable<Address> toCompanion() {
    return AddressRecordsCompanion(
      city: Value(city),
      neighborhood: Value(neighborhood),
      state: Value(state),
      street: Value(street),
      zipCode: Value(zipCode),
    );
  }
}
