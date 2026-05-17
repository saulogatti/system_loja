import 'package:drift/drift.dart';
import 'package:system_loja/data/database/table/categories_records.dart';

class ProductsRecords extends Table {
  late final code = text().unique()();

  late final IntColumn id = integer().autoIncrement()();

  /// ID da categoria (chave estrangeira para categories_records)
  IntColumn get categoryId =>
      integer().nullable().references(CategoriesRecords, #id)();
  TextColumn get description => text()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();
  IntColumn get stockQuantity => integer()();
}
