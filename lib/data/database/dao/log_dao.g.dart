// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_dao.dart';

// ignore_for_file: type=lint
mixin _$LogDaoMixin on DatabaseAccessor<SystemDatabase> {
  $LogsRecordsTable get logsRecords => attachedDatabase.logsRecords;
  LogDaoManager get managers => LogDaoManager(this);
}

class LogDaoManager {
  final _$LogDaoMixin _db;
  LogDaoManager(this._db);
  $$LogsRecordsTableTableManager get logsRecords =>
      $$LogsRecordsTableTableManager(_db.attachedDatabase, _db.logsRecords);
}
