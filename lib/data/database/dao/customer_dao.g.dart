// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_dao.dart';

// ignore_for_file: type=lint
mixin _$CustomerDaoMixin on DatabaseAccessor<AppDatabase> {
  $CustomerRecordsTable get customerRecords => attachedDatabase.customerRecords;
  CustomerDaoManager get managers => CustomerDaoManager(this);
}

class CustomerDaoManager {
  final _$CustomerDaoMixin _db;
  CustomerDaoManager(this._db);
  $$CustomerRecordsTableTableManager get customerRecords =>
      $$CustomerRecordsTableTableManager(
        _db.attachedDatabase,
        _db.customerRecords,
      );
}
