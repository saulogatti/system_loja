import 'package:drift/drift.dart';
import 'package:system_loja/data/database/table/notas_table.dart';
import 'package:system_loja/data/database/table/products_records.dart';

class NotaItensTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get notaId => integer().references(NotasTable, #id)();
  IntColumn get produtoId => integer().references(ProductsRecords, #id)();
  IntColumn get quantidade => integer()();
}
