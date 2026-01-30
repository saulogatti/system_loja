import 'package:drift/drift.dart';
import 'package:system_loja/core/models/company.dart';

@UseRowClass(Company)
class CompanyRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get corporateName => text()();
  TextColumn get cnpj => text().unique()();
  TextColumn get email => text().nullable()();
  TextColumn get street => text().nullable()();
  TextColumn get zipCode => text().nullable()();
  TextColumn get neighborhood => text().nullable()();
  TextColumn get city => text().nullable()();
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
}
