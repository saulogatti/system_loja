// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file
// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_null_checks, unused_element, unnecessary_lambdas, inference_failure_on_collection_literal

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
