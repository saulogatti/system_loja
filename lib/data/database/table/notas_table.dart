import 'package:drift/drift.dart';

class     NotasTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clienteId => integer().customConstraint('REFERENCES clientes(id)')();
  DateTimeColumn get data => dateTime()();
}
