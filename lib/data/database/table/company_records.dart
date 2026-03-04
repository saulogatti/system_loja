import 'package:drift/drift.dart';
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/company.dart';

@UseRowClass(Company)
class CompanyRecords extends Table {
  TextColumn get address => text().map(Address.converter).nullable()();
  TextColumn get cnpj => text().unique()();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();
}
