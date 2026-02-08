import 'package:drift/drift.dart';
import 'package:system_loja/core/models/address.dart';

@UseRowClass(Address)
class AddressRecords extends Table {
  TextColumn get city => text()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
  TextColumn get neighborhood => text()();

  TextColumn get state => text()();
  TextColumn get street => text()();
  TextColumn get zipCode => text()();
}
