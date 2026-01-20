import 'package:drift/drift.dart';
import 'package:system_loja/data/database/table/clientes_records.dart';

class NotasTable extends Table {
  IntColumn get clienteId => integer().references(ClientesRecords, #id)();
  DateTimeColumn get data => dateTime()();
  IntColumn get id => integer().autoIncrement()();
}


