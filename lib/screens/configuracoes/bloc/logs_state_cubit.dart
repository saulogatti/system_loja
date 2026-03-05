import 'package:meta/meta.dart';
import 'package:system_loja/core/models/activity_log.dart';

class LogsError extends LogsState {
  final String message;

  const LogsError(this.message);
}

class LogsLoaded extends LogsState {
  final List<ActivityLog> logs;

  const LogsLoaded(this.logs);
}

class LogsLoading extends LogsState {
  const LogsLoading();
}

@immutable
sealed class LogsState {
  const LogsState();
}

class LogsStateInitial extends LogsState {
  const LogsStateInitial();
}
