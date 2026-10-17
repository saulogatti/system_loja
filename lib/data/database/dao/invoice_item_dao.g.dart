// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file
// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_null_checks, unused_element, unnecessary_lambdas, inference_failure_on_collection_literal

part of 'invoice_item_dao.dart';

// ignore_for_file: type=lint
mixin _$InvoiceItemDaoMixin on DatabaseAccessor<AppDatabase> {
  $InvoiceItemsRecordsTable get invoiceItemsRecords =>
      attachedDatabase.invoiceItemsRecords;
  InvoiceItemDaoManager get managers => InvoiceItemDaoManager(this);
}

class InvoiceItemDaoManager {
  final _$InvoiceItemDaoMixin _db;
  InvoiceItemDaoManager(this._db);
  $$InvoiceItemsRecordsTableTableManager get invoiceItemsRecords =>
      $$InvoiceItemsRecordsTableTableManager(
        _db.attachedDatabase,
        _db.invoiceItemsRecords,
      );
}
