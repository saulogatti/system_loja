import 'package:drift/drift.dart';
import 'package:system_loja/core/models/activity_log.dart';

@UseRowClass(ActivityLog, generateInsertable: true)
@UseRowClass(ActivityLog, generateInsertable: true)
class LogsRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get actionType => intEnum<ActionType>()();
  TextColumn get entity => text()();
  IntColumn get userId => integer().named('user_id')();
  TextColumn get userName => text().named('user_name')();
  DateTimeColumn get timestamp =>
      dateTime().named('timestamp').withDefault(currentDateAndTime)();
  TextColumn get details => text().withDefault(const Constant(''))();
  DateTimeColumn get registrationDate =>
      dateTime().named('registration_date').withDefault(currentDateAndTime)();
  DateTimeColumn get lastUpdatedDate =>
      dateTime().named('last_updated_date').withDefault(currentDateAndTime)();
}
