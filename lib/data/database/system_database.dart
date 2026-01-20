import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/data/database/dao/users_dao.dart';
import 'package:system_loja/data/database/table/users_records.dart';

part 'system_database.g.dart';

@DriftDatabase(tables: [UsersRecords], daos: [UsersDao])
class SystemDatabase extends _$SystemDatabase {
  static final _nameBd = 'system_database';
  SystemDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;
  static QueryExecutor _openConnection() {
    return driftDatabase(name: _nameBd);
  }
}
