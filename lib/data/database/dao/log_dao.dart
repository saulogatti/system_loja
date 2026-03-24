import 'package:drift/drift.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/data/database/extension/log_to_companion.dart';
import 'package:system_loja/data/database/mapper/drift_to_domain.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/data/database/table/system/logs_records.dart';

part 'log_dao.g.dart';

/// DAO para gerenciar operações CRUD de logs de atividade no [SystemDatabase].
///
/// Permite inserir, buscar e remover registros de auditoria ([ActivityLog])
/// com filtros por data, tipo de ação, entidade e usuário.
@DriftAccessor(tables: [LogsRecords])
class LogDao extends DatabaseAccessor<SystemDatabase> with _$LogDaoMixin {
  LogDao(super.db);

  /// Remove todos os registros de log da tabela.
  ///
  /// Retorna o número de linhas removidas.
  Future<int> deleteAll() {
    return delete(logsRecords).go();
  }

  /// Remove todos os logs com timestamp anterior a [dataLimite].
  ///
  /// Retorna true se ao menos um log foi removido.
  Future<bool> deleteLogsBefore(DateTime dataLimite) async {
    return await (delete(logsRecords)
          ..where((tbl) => tbl.timestamp.isSmallerThanValue(dataLimite)))
        .go()
        .then((rowsAffected) => rowsAffected > 0);
  }

  /// Retorna todos os logs ordenados do mais recente para o mais antigo.
  Future<List<ActivityLog>> getAll() async {
    final rows = await (select(
      logsRecords,
    )..orderBy([(t) => OrderingTerm.desc(t.timestamp)])).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  /// Retorna logs cujo timestamp está entre [dataInicio] e [dataFim] (inclusivo).
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

  /// Retorna logs filtrados pelo tipo de ação [tipoAcao].
  Future<List<ActivityLog>> getWithAction(ActionType tipoAcao) async {
    final rows = await (select(
      logsRecords,
    )..where((tbl) => tbl.actionType.isValue(tipoAcao.index))).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  /// Retorna logs filtrados pelo nome da entidade [entity].
  Future<List<ActivityLog>> getWithFilter(String entity) async {
    final rows = await (select(
      logsRecords,
    )..where((tbl) => tbl.entity.equals(entity))).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  /// Retorna logs filtrados pelo ID do usuário [userId].
  Future<List<ActivityLog>> getWithUserId(int userId) async {
    final rows = await (select(
      logsRecords,
    )..where((tbl) => tbl.userId.equals(userId))).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  /// Busca um log de atividade pelo [id].
  ///
  /// Retorna null se o registro não for encontrado.
  Future<ActivityLog?> load(int id) async {
    final row = await (select(
      logsRecords,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row?.toDomain();
  }

  /// Remove um log pelo [id].
  ///
  /// Retorna o número de linhas afetadas (normalmente 1 ou 0).
  Future<int> removeLog(int id) {
    return (delete(logsRecords)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Salva um novo log de atividade.
  ///
  /// Usa `insertOrIgnore` para evitar duplicatas silenciosas.
  /// Retorna o ID do registro inserido.
  Future<int> save(ActivityLog log) {
    return into(
      logsRecords,
    ).insert(log.toCompanion(), mode: InsertMode.insertOrIgnore);
  }
}
