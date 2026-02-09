import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/core/utils/command_result.dart';

abstract interface class ILogRepository {
  Future<ResultStatus<bool, String>> clearOldLogs(DateTime cutoffDate);
  Future<ResultStatus<void, String>> createAndLogEntry({
    required ActionType logActionType,
    required String entityName,
    required int userId,
    required String username,
    String logDetails = '',
  });
  Future<ResultStatus<List<ActivityLog>, String>> fetchAllLogs();
  Future<ResultStatus<List<ActivityLog>, String>> fetchLogsByActionType(
    ActionType actionType,
  );
  Future<ResultStatus<List<ActivityLog>, String>> fetchLogsByEntity(
    String entity,
  );
  Future<ResultStatus<List<ActivityLog>, String>> fetchLogsByPeriod(
    DateTime startDate,
    DateTime endDate,
  );
  Future<ResultStatus<List<ActivityLog>, String>> fetchLogsByUser(int userId);
  Future<ResultStatus<void, String>> saveActivityLog(ActivityLog log);
}
