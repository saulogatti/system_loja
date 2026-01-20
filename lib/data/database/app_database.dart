import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/data/database/cliente_dao.dart';
import 'package:system_loja/data/database/invoice_dao.dart';
import 'package:system_loja/data/database/invoice_item_dao.dart';
import 'package:system_loja/data/database/product_dao.dart';
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
    ClientesRecords,
    ProductsRecords,
    InvoicesRecords,
    InvoiceItemsRecords,
  ],
  daos: [
    ClienteDao,
    ProductDao,
    InvoiceDao,
    InvoiceItemDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;
  
  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: ' system_loja',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
