import 'package:drift/drift.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/data/database/table/system/logs_records.dart';

part 'log_dao.g.dart';

@DriftAccessor(tables: [LogsRecords])
class LogDao extends DatabaseAccessor<SystemDatabase> with _$LogDaoMixin {
  LogDao(super.db);
  
}
