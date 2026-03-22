import 'package:drift/drift.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/data/database/extension/log_to_companion.dart';
import 'package:system_loja/data/database/mapper/drift_to_domain.dart';
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
  Future<List<ActivityLog>> getAll() async {
    final rows = await (select(
      logsRecords,
    )..orderBy([(t) => OrderingTerm.desc(t.timestamp)])).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  Future<List<ActivityLog>> getInDate(
    DateTime dataInicio,
    DateTime dataFim,
  ) async {
    final rows =
        await (select(logsRecords)..where(
              (tbl) => tbl.timestamp.isBetweenValues(dataInicio, dataFim),
            ))
            .get();
    return rows.map((e) => e.toDomain()).toList();
  }

  Future<List<ActivityLog>> getWithAction(ActionType tipoAcao) async {
    final rows = await (select(
      logsRecords,
    )..where((tbl) => tbl.actionType.isValue(tipoAcao.index))).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  Future<List<ActivityLog>> getWithFilter(String entity) async {
    final rows = await (select(
      logsRecords,
    )..where((tbl) => tbl.entity.equals(entity))).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  Future<List<ActivityLog>> getWithUserId(int userId) async {
    final rows = await (select(
      logsRecords,
    )..where((tbl) => tbl.userId.equals(userId))).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  // Carregar um registro de log por ID
  Future<ActivityLog?> load(int id) async {
    final row = await (select(
      logsRecords,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row?.toDomain();
  }

  // Deletar um registro de log por ID
  Future<int> removeLog(int id) {
    return (delete(logsRecords)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Salvar um novo registro de log
  Future<int> save(ActivityLog log) {
    return into(
      logsRecords,
    ).insert(log.toCompanion(), mode: InsertMode.insertOrIgnore);
  }
}
