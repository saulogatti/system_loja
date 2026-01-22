import 'package:drift/drift.dart';
import 'package:system_loja/core/models/activity_log.dart';

@UseRowClass(ActivityLog, generateInsertable: true)
class LogsRecords extends Table {
  TextColumn get action => text().withDefault(const Constant('LER'))();
  TextColumn get details => text().withDefault(const Constant(''))();
  TextColumn get entity => text()();
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate =>
      dateTime().named('last_updated_date').withDefault(currentDateAndTime)();
  DateTimeColumn get registrationDate =>
      dateTime().named('registration_date').withDefault(currentDateAndTime)();
  DateTimeColumn get timestamp =>
      dateTime().named('timestamp').withDefault(currentDateAndTime)();
  IntColumn get userId => integer().named('user_id')();
  TextColumn get userName => text().named('user_name')();
}
