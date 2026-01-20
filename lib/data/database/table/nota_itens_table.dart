import 'package:drift/drift.dart';

class   NotaItensTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get notaId => integer().customConstraint('REFERENCES notas(id)')();
  IntColumn get produtoId => integer().customConstraint('REFERENCES produtos(id)')();
  IntColumn get quantidade => integer()();
}
