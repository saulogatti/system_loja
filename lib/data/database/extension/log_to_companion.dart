import 'package:drift/drift.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/data/database/system_database.dart';

extension LogToCompanion on ActivityLog {
  /// Converte um modelo de domínio ActivityLog para Companion usado em insert.
  LogsRecordsCompanion toCompanion() {
    return LogsRecordsCompanion.insert(
      actionType: (actionType),
      details: Value(details),
      timestamp: Value(timestamp),
      entity: entity,
      userId: (userId),
      userName: userName,
    );
  }
}
