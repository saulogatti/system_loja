import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/interface/i_log_repository.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/dao/log_dao.dart';

class LogRepository with LoggerClassMixin implements ILogRepository {
  final LogDao _logDao;
  LogRepository({required LogDao logDao}) : _logDao = logDao;

  /// Limpa logs antigos (opcional - para manutenção)
  ///
  /// Remove logs mais antigos que a data especificada.
  @override
  Future<ResultStatus<bool, String>> clearOldLogs(DateTime cutoffDate) async {
    try {
      logInfo('Logs antigos removidos até $cutoffDate');
      final result = await _logDao.deleteLogsBefore(cutoffDate);
      return ResultStatus.success(result);
    } catch (e) {
      return ResultStatus.error('Falha ao remover logs antigos: $e');
    }
  }

  /// Cria e registra um log de atividade
  @override
  Future<ResultStatus<void, String>> createAndLogEntry({
    required ActionType logActionType,
    required String entityName,
    required int userId,
    required String username,
    String logDetails = '',
  }) async {
    try {
      final log = ActivityLog(
        action: logActionType.name,
        entity: entityName,
        userId: userId,
        userName: username,
        details: logDetails,
      );
      final result = await saveActivityLog(log);
      return result;
    } catch (e) {
      return ResultStatus.error('Falha ao criar e registrar log: $e');
    }
  }

  /// Obtém todos os logs
  @override
  Future<ResultStatus<List<ActivityLog>, String>> fetchAllLogs() async {
    try {
      final result = await _logDao.getAll();
      return ResultStatus.success(result);
    } catch (e) {
      return ResultStatus.error('Falha ao obter logs: $e');
    }
  }

  /// Obtém logs por tipo de ação
  @override
  Future<ResultStatus<List<ActivityLog>, String>> fetchLogsByActionType(
    ActionType actionType,
  ) async {
    try {
      final result = await _logDao.getWithAction(actionType);
      return ResultStatus.success(result);
    } catch (e) {
      return ResultStatus.error('Falha ao obter logs por tipo de ação: $e');
    }
  }

  /// Obtém logs de uma entidade específica
  @override
  Future<ResultStatus<List<ActivityLog>, String>> fetchLogsByEntity(
    String entity,
  ) async {
    try {
      final result = await _logDao.getWithFilter(entity);
      return ResultStatus.success(result);
    } catch (e) {
      return ResultStatus.error('Falha ao obter logs por entidade: $e');
    }
  }

  /// Obtém logs por período
  ///
  /// Inclui logs nos limites do período (dataInicio e dataFim são inclusos).
  @override
  Future<ResultStatus<List<ActivityLog>, String>> fetchLogsByPeriod(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final result = await _logDao.getInDate(startDate, endDate);
      return ResultStatus.success(result);
    } catch (e) {
      return ResultStatus.error('Falha ao obter logs por período: $e');
    }
  }

  /// Obtém logs de um usuário específico
  @override
  Future<ResultStatus<List<ActivityLog>, String>> fetchLogsByUser(
    int userId,
  ) async {
    try {
      final result = await _logDao.getWithUserId(userId);
      return ResultStatus.success(result);
    } catch (e) {
      return ResultStatus.error('Falha ao obter logs por usuário: $e');
    }
  }

  /// Registra uma nova atividade no log
  ///
  /// Este método é usado para registrar todas as operações CRUD
  /// realizadas no sistema.
  @override
  Future<ResultStatus<void, String>> saveActivityLog(ActivityLog log) async {
    try {
      await _logDao.save(log);
      logInfo(
        'Log registrado: ${log.actionType.name} - ${log.entity} - ${log.userName}',
      );
      return ResultStatus.success(null);
    } catch (e) {
      return ResultStatus.error('Falha ao salvar log de atividade: $e');
    }
  }
}
