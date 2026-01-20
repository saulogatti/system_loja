import 'package:drift/drift.dart';

class ClientesRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get cpf => text().unique()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  TextColumn get address => text()();
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
}
