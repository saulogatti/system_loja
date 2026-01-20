import 'package:drift/drift.dart';
import 'package:system_loja/core/models/user.dart';

@UseRowClass(User, generateInsertable: true)
class UsersRecords extends Table {
  TextColumn get email => text().unique()();
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
  TextColumn get name => text()();
  TextColumn get passwordHash => text()();

  IntColumn get permission => integer()();

  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();
}
