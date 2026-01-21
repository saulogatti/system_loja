import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:system_loja/core/models/log_atividade.dart';
import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/data/database/dao/log_dao.dart';
import 'package:system_loja/data/database/dao/users_dao.dart';
import 'package:system_loja/data/database/table/system/logs_records.dart';
import 'package:system_loja/data/database/table/system/users_records.dart';

part 'system_database.g.dart';

@DriftDatabase(tables: [UsersRecords, LogsRecords], daos: [UsersDao, LogDao])
class SystemDatabase extends _$SystemDatabase {
  static final _nameBd = 'system_database';
  SystemDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;
  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: _nameBd,
      native: DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
