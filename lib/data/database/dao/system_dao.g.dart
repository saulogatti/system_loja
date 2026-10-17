// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file
// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_null_checks, unused_element, unnecessary_lambdas, inference_failure_on_collection_literal

part of 'system_dao.dart';

// ignore_for_file: type=lint
mixin _$SystemDaoMixin on DatabaseAccessor<SystemDatabase> {
  $SystemRecordsTable get systemRecords => attachedDatabase.systemRecords;
  SystemDaoManager get managers => SystemDaoManager(this);
}

class SystemDaoManager {
  final _$SystemDaoMixin _db;
  SystemDaoManager(this._db);
  $$SystemRecordsTableTableManager get systemRecords =>
      $$SystemRecordsTableTableManager(_db.attachedDatabase, _db.systemRecords);
}
