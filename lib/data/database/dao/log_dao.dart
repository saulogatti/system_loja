import 'package:drift/drift.dart';
import 'package:system_loja/core/models/log_atividade.dart';
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
          ..where((tbl) => tbl.dataHora.isSmallerThanValue(dataLimite)))
        .go()
        .then((rowsAffected) => rowsAffected > 0);
  }

  // Obter todos os registros de log
  Future<List<LogAtividade>> getAll() {
    return (select(
      logsRecords,
    )..orderBy([(t) => OrderingTerm.desc(t.dataHora)])).get();
  }

  Future<List<LogAtividade>> getInDate(
    DateTime dataInicio,
    DateTime dataFim,
  ) async {
    return await (select(
      logsRecords,
    )..where((tbl) => tbl.dataHora.isBetweenValues(dataInicio, dataFim))).get();
  }

  Future<List<LogAtividade>> getWithAction(TipoAcao tipoAcao) async {
    return await (select(
      logsRecords,
    )..where((tbl) => tbl.action.equals(tipoAcao.name))).get();
  }

  Future<List<LogAtividade>> getWithFilter(String entidade) async {
    return await (select(
      logsRecords,
    )..where((tbl) => tbl.entidade.equals(entidade))).get();
  }

  Future<List<LogAtividade>> getWithUserId(int usuarioId) async {
    return await (select(
      logsRecords,
    )..where((tbl) => tbl.usuarioId.equals(usuarioId))).get();
  }

  // Carregar um registro de log por ID
  Future<LogAtividade?> load(int id) {
    return (select(
      logsRecords,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // Deletar um registro de log por ID
  Future<int> removeLog(int id) {
    return (delete(logsRecords)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Salvar um novo registro de log
  Future<int> save(LogAtividade log) {
    return into(logsRecords).insert(log.toInsertable());
  }
}
