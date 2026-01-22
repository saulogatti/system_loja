import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/data/database/dao/log_dao.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

class LogRepository with LoggerClassMixin {
  final LogDao _logDao = AppInjection.instance.systemDatabase.logDao;

  /// Limpa logs antigos (opcional - para manutenção)
  ///
  /// Remove logs mais antigos que a data especificada.
  Future<bool> clearOldLogs(DateTime cutoffDate) async {
    logInfo('Logs antigos removidos até $cutoffDate');
    return await _logDao.deleteLogsBefore(cutoffDate);
  }

  /// Cria e registra um log de atividade
  Future<void> createAndLogEntry({
    required ActionType logActionType,
    required String entityName,
    required int userId,
    required String username,
    String logDetails = '',
  }) async {
    final log = ActivityLog(
      id: 0,
      action: logActionType.name,
      entity: entityName,
      userId: userId,
      userName: username,
      details: logDetails,
    );
    await saveActivityLog(log);
  }

  /// Obtém todos os logs
  Future<List<ActivityLog>> fetchAllLogs() async {
    return await _logDao.getAll();
  }

  /// Obtém logs por tipo de ação
  Future<List<ActivityLog>> fetchLogsByActionType(ActionType actionType) async {
    return await _logDao.getWithAction(actionType);
  }

  /// Obtém logs de uma entidade específica
  Future<List<ActivityLog>> fetchLogsByEntity(String entity) async {
    return await _logDao.getWithFilter(entity);
  }

  /// Obtém logs por período
  ///
  /// Inclui logs nos limites do período (dataInicio e dataFim são inclusos).
  Future<List<ActivityLog>> fetchLogsByPeriod(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await _logDao.getInDate(startDate, endDate);
  }

  /// Obtém logs de um usuário específico
  Future<List<ActivityLog>> fetchLogsByUser(int userId) async {
    return await _logDao.getWithUserId(userId);
  }

  /// Registra uma nova atividade no log
  ///
  /// Este método é usado para registrar todas as operações CRUD
  /// realizadas no sistema.
  Future<void> saveActivityLog(ActivityLog log) async {
    await _logDao.save(log);
    logInfo(
      'Log registrado: ${log.actionType.name} - ${log.entity} - ${log.userName}',
    );
  }
}
