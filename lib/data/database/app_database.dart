import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/data/database/cliente_dao.dart';
import 'package:system_loja/data/database/product_dao.dart';
import 'package:system_loja/data/database/table/clientes_records.dart';
import 'package:system_loja/data/database/table/products_records.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [ClientesRecords, ProductsRecords],
  daos: [ClienteDao, ProductDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
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
