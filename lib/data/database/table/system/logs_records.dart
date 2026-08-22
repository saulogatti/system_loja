import 'package:drift/drift.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/data/database/system_database.dart';

/// Tabela Drift de logs de auditoria no [SystemDatabase].
///
/// {@category persistencia}
/// {@subCategory Sistema}
class LogsRecords extends Table {
  IntColumn get actionType => intEnum<ActionType>()();
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
