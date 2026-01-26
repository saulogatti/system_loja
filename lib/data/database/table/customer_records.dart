import 'package:drift/drift.dart';
import 'package:system_loja/core/models/customer.dart';

@UseRowClass(Customer)
class CustomerRecords extends Table {
  TextColumn get address => text().nullable()();
  TextColumn get cpf => text().unique()();
  TextColumn get email => text().nullable()();
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();
}
