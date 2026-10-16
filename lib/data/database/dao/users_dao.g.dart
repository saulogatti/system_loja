// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file
// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_null_checks, unused_element, unnecessary_lambdas, inference_failure_on_collection_literal

part of 'users_dao.dart';

// ignore_for_file: type=lint
mixin _$UsersDaoMixin on DatabaseAccessor<SystemDatabase> {
  $UsersRecordsTable get usersRecords => attachedDatabase.usersRecords;
  UsersDaoManager get managers => UsersDaoManager(this);
}

class UsersDaoManager {
  final _$UsersDaoMixin _db;
  UsersDaoManager(this._db);
  $$UsersRecordsTableTableManager get usersRecords =>
      $$UsersRecordsTableTableManager(_db.attachedDatabase, _db.usersRecords);
}
