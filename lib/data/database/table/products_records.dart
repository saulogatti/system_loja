import 'package:drift/drift.dart';
import 'package:system_loja/core/models/product.dart';
@UseRowClass(Product, generateInsertable: true)
class ProductsRecords extends Table {
  TextColumn get category => text()();
  TextColumn get code => text()();
  TextColumn get description => text()();
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate =>
      dateTime().nullable()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();
  IntColumn get stockQuantity => integer()();
}
