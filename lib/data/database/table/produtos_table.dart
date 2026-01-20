import 'package:drift/drift.dart';

class   ProdutosTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text()();
  RealColumn get preco => real()();
}
