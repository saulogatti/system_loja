import 'package:drift/drift.dart';
import 'package:system_loja/data/entry/user_entry.dart';

@UseRowClass(UserEntry)
class UsersRecords extends Table {
  TextColumn get email => text().nullable()();
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
  TextColumn get name => text()();
  TextColumn get passwordHash => text()();
  IntColumn get permission => integer()();

  DateTimeColumn get registrationDate => dateTime().withDefault(currentDateAndTime)();
}
