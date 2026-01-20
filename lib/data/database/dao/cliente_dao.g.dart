// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente_dao.dart';

// ignore_for_file: type=lint
mixin _$ClienteDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClientesRecordsTable get clientesRecords => attachedDatabase.clientesRecords;
  ClienteDaoManager get managers => ClienteDaoManager(this);
}

class ClienteDaoManager {
  final _$ClienteDaoMixin _db;
  ClienteDaoManager(this._db);
  $$ClientesRecordsTableTableManager get clientesRecords =>
      $$ClientesRecordsTableTableManager(
        _db.attachedDatabase,
        _db.clientesRecords,
      );
}
