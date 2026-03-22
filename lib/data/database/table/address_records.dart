import 'package:drift/drift.dart';

class AddressRecords extends Table {
  TextColumn get city => text()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
  TextColumn get neighborhood => text()();

  TextColumn get state => text()();
  TextColumn get street => text()();
  TextColumn get zipCode => text()();
}
