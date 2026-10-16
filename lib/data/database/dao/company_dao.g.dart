// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file
// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_null_checks, unused_element, unnecessary_lambdas, inference_failure_on_collection_literal

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
      $$CompanyRecordsTableTableManager(
        _db.attachedDatabase,
        _db.companyRecords,
      );
}
