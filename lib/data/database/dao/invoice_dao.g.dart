// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file
// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_null_checks, unused_element, unnecessary_lambdas, inference_failure_on_collection_literal

part of 'invoice_dao.dart';

// ignore_for_file: type=lint
mixin _$InvoiceDaoMixin on DatabaseAccessor<AppDatabase> {
  $InvoicesRecordsTable get invoicesRecords => attachedDatabase.invoicesRecords;
  InvoiceDaoManager get managers => InvoiceDaoManager(this);
}

class InvoiceDaoManager {
  final _$InvoiceDaoMixin _db;
  InvoiceDaoManager(this._db);
  $$InvoicesRecordsTableTableManager get invoicesRecords =>
      $$InvoicesRecordsTableTableManager(
        _db.attachedDatabase,
        _db.invoicesRecords,
      );
}
