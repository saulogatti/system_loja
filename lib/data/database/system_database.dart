import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/data/converter/price_configuration_codec.dart';
import 'package:system_loja/data/database/dao/log_dao.dart';
import 'package:system_loja/data/database/dao/system_dao.dart';
import 'package:system_loja/data/database/dao/users_dao.dart';
import 'package:system_loja/data/database/table/system/logs_records.dart';
import 'package:system_loja/data/database/table/system/system_records.dart';
import 'package:system_loja/data/database/table/system/users_records.dart';
import 'package:system_loja/data/entry/system_configuration_entry.dart';
import 'package:system_loja/data/entry/system_user_data_entry.dart';
import 'package:system_loja/data/entry/user_entry.dart';

part 'system_database.g.dart';

@DriftDatabase(
  tables: [UsersRecords, LogsRecords, SystemRecords],
  daos: [UsersDao, LogDao, SystemDao],
)
class SystemDatabase extends _$SystemDatabase {
  static final _nameBd = 'system_database';
  SystemDatabase({QueryExecutor? executor})
    : super(executor ?? _openConnection());
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) => m.createAll(),
    onUpgrade: (Migrator m, int from, int to) async {},
  );
  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: _nameBd,
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
      native: DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
