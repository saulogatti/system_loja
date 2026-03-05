import 'package:drift/drift.dart';
import 'package:system_loja/data/database/table/customer_records.dart';

class NotasTable extends Table {
  IntColumn get clienteId => integer().references(CustomerRecords, #id)();
  DateTimeColumn get data => dateTime()();
  IntColumn get id => integer().autoIncrement()();
}
