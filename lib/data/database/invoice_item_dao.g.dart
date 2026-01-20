// GENERATED CODE - DO NOT MODIFY BY HAND

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
