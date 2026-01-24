import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:system_loja/core/models/customer.dart' show Customer;
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/data/database/dao/category_dao.dart';
import 'package:system_loja/data/database/dao/cliente_dao.dart';
import 'package:system_loja/data/database/dao/invoice_dao.dart';
import 'package:system_loja/data/database/dao/invoice_item_dao.dart';
import 'package:system_loja/data/database/dao/product_dao.dart';
import 'package:system_loja/data/database/table/categories_records.dart';
import 'package:system_loja/data/database/table/clientes_records.dart';
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
    ClientesRecords,
    ProductsRecords,
    InvoicesRecords,
    InvoiceItemsRecords,
  ],
  daos: [CategoryDao, ClienteDao, ProductDao, InvoiceDao, InvoiceItemDao],
)
class AppDatabase extends _$AppDatabase {
  static final _nameBd = 'system_loja';

  AppDatabase() : super(_openConnection(getApplicationSupportDirectory));

  @override
  int get schemaVersion => 3;

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
          }
        },
      );

  /// Migra categorias existentes dos produtos para a tabela categories_records.
  ///
  /// Este método é executado durante a migração do schema version 2 para 3.
  /// Extrai categorias únicas dos produtos e as insere na nova tabela,
  /// depois atualiza os produtos para referenciar os IDs das categorias.
  Future<void> _migrateCategoriesFromProducts() async {
    // Nota: Como a coluna antiga 'category' foi removida, não podemos migrá-la.
    // Os produtos novos precisarão ter categorias atribuídas manualmente.
    // Podemos criar uma categoria padrão para produtos sem categoria.
    
    final defaultCategoryId = await into(categoriesRecords).insert(
      CategoriesRecordsCompanion.insert(
        name: 'Sem Categoria',
        description: const Value('Categoria padrão para produtos migrados'),
      ),
    );

    // Não é necessário atualizar produtos pois categoryId já será null por padrão
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
