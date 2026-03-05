import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_log_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_state_cubit.dart';

class LogsCubit extends Cubit<LogsState> {
  final ILogRepository _logRepository;
  LogsCubit(this._logRepository) : super(const LogsStateInitial());

  Future<void> fetchActivesLogs() async {
    final logs = await _logRepository.fetchAllLogs();
    switch (logs) {
      case ResultSuccess(:final result):
        emit(LogsLoaded(result));
      case ResultError(:final resultError):
        emit(LogsError(resultError));
    }
  }
}
