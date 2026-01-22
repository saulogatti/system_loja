import 'package:drift/drift.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/data/database/table/system/logs_records.dart';

part 'log_dao.g.dart';

@DriftAccessor(tables: [LogsRecords])
class LogDao extends DatabaseAccessor<SystemDatabase> with _$LogDaoMixin {
  LogDao(super.db);

  // Deletar todos os registros de log
  Future<int> deleteAll() {
    return delete(logsRecords).go();
  }

  Future<bool> deleteLogsBefore(DateTime dataLimite) async {
    return await (delete(logsRecords)
          ..where((tbl) => tbl.timestamp.isSmallerThanValue(dataLimite)))
        .go()
        .then((rowsAffected) => rowsAffected > 0);
  }

  // Obter todos os registros de log
  Future<List<ActivityLog>> getAll() {
    return (select(
      logsRecords,
    )..orderBy([(t) => OrderingTerm.desc(t.timestamp)])).get();
  }

  Future<List<ActivityLog>> getInDate(
    DateTime dataInicio,
    DateTime dataFim,
  ) async {
    return await (select(logsRecords)
          ..where((tbl) => tbl.timestamp.isBetweenValues(dataInicio, dataFim)))
        .get();
  }

  Future<List<ActivityLog>> getWithAction(ActionType tipoAcao) async {
    return await (select(
      logsRecords,
    )..where((tbl) => tbl.actionType.isValue(tipoAcao.index))).get();
  }

  Future<List<ActivityLog>> getWithFilter(String entity) async {
    return await (select(
      logsRecords,
    )..where((tbl) => tbl.entity.equals(entity))).get();
  }

  Future<List<ActivityLog>> getWithUserId(int userId) async {
    return await (select(
      logsRecords,
    )..where((tbl) => tbl.userId.equals(userId))).get();
  }

  // Carregar um registro de log por ID
  Future<ActivityLog?> load(int id) {
    return (select(
      logsRecords,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // Deletar um registro de log por ID
  Future<int> removeLog(int id) {
    return (delete(logsRecords)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Salvar um novo registro de log
  Future<int> save(ActivityLog log) {
    return into(logsRecords).insert(log.toInsertable());
  }
}
