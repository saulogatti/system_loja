// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_dao.dart';

// ignore_for_file: type=lint
mixin _$CompanyDaoMixin on DatabaseAccessor<AppDatabase> {
  $CompanyRecordsTable get companyRecords => attachedDatabase.companyRecords;
  CompanyDaoManager get managers => CompanyDaoManager(this);
}

class CompanyDaoManager {
  final _$CompanyDaoMixin _db;
  CompanyDaoManager(this._db);
  $$CompanyRecordsTableTableManager get companyRecords =>
      $$CompanyRecordsTableTableManager(_db.attachedDatabase, _db.companyRecords);
}
