// GENERATED CODE - DO NOT MODIFY BY HAND

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
