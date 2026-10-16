// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file
// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_null_checks, unused_element, unnecessary_lambdas, inference_failure_on_collection_literal

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
      $$AddressRecordsTableTableManager(
        _db.attachedDatabase,
        _db.addressRecords,
      );
}
