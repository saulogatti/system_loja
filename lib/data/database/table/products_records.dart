import 'package:drift/drift.dart';
import 'package:system_loja/core/models/product.dart';

@UseRowClass(Product,  )
class ProductsRecords extends Table {
  late final code = text().unique()();
  TextColumn get category => text()();
  TextColumn get description => text()();
 late final IntColumn id = integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();
  IntColumn get stockQuantity => integer()();

  
}
