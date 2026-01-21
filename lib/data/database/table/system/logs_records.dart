import 'package:drift/drift.dart';
import 'package:system_loja/core/models/log_atividade.dart';

@UseRowClass(LogAtividade, generateInsertable: true)
class LogsRecords extends Table {
  TextColumn get action => text().withDefault(const Constant('LER'))();
  DateTimeColumn get dataHora =>
      dateTime().named('data_hora').withDefault(currentDateAndTime)();
  TextColumn get detalhes => text().withDefault(const Constant(''))();
  TextColumn get entidade => text()();
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate =>
      dateTime().named('last_updated_date').withDefault(currentDateAndTime)();
  DateTimeColumn get registrationDate =>
      dateTime().named('registration_date').withDefault(currentDateAndTime)();
  IntColumn get usuarioId => integer().named('usuario_id')();
  TextColumn get usuarioNome => text().named('usuario_nome')();
}
