import 'package:drift/drift.dart';

class ClientesRecords extends Table {
  TextColumn get address => text()();
  TextColumn get cpf => text().unique()();
  TextColumn get email => text()();
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
  TextColumn get name => text()();
  TextColumn get phone => text()();
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();
}
