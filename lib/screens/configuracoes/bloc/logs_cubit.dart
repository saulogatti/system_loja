import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/repository/system/log_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_state_cubit.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

class LogsCubit extends Cubit<LogsState> {
  final LogRepository _logRepository = AppInjection.instance.logRepository;
  LogsCubit() : super(const LogsStateInitial());

  Future<void> fetchLogs() async {
    final logs = await _logRepository.fetchAllLogs();
    switch (logs) {
      case ResultSuccess(:final result):
        emit(LogsLoaded(result));
      case ResultError(:final resultError):
        emit(LogsError(resultError));
    }
  }
}
