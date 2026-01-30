import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/system_errors/system_error.dart';
part 'logs_system_state.freezed.dart';
@freezed
sealed class LogsSystemState  with _$LogsSystemState {
  const factory LogsSystemState.initial() = LogsSystemInitial;
  const factory LogsSystemState.loading() = LogsSystemLoading;
  const factory LogsSystemState.loaded(List<SystemError> logs) = LogsSystemLoaded;
  const factory LogsSystemState.error(String message) = LogsSystemError;
}
 