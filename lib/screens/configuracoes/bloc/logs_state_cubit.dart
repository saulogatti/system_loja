import 'package:meta/meta.dart';
import 'package:system_loja/core/models/activity_log.dart';

class LogsError extends LogsState {

  const LogsError(this.message);
  final String message;
}

class LogsLoaded extends LogsState {

  const LogsLoaded(this.logs);
  final List<ActivityLog> logs;
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
