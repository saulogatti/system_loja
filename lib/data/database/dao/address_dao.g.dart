// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_dao.dart';

// ignore_for_file: type=lint
mixin _$AddressDaoMixin on DatabaseAccessor<AppDatabase> {
  $AddressRecordsTable get addressRecords => attachedDatabase.addressRecords;
  AddressDaoManager get managers => AddressDaoManager(this);
}

class AddressDaoManager {
  final _$AddressDaoMixin _db;
  AddressDaoManager(this._db);
  $$AddressRecordsTableTableManager get addressRecords =>
      $$AddressRecordsTableTableManager(_db.attachedDatabase, _db.addressRecords);
}
