// GENERATED CODE - DO NOT MODIFY BY HAND

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
