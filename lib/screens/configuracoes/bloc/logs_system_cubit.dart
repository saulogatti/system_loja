import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/managers/system_error_manager.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_system_state.dart';

class LogsSystemCubit extends Cubit<LogsSystemState> {
  LogsSystemCubit() : super(const LogsSystemState.initial());

  void clearLogs() {
    emit(const LogsSystemState.loading());
    SystemErrorManager.instance.clearAllErrors();
    emit(const LogsSystemState.loaded([]));
  }

  Future<void> loadLogs() async {
    // Implement log loading logic here
    emit(const LogsSystemState.loading());
    final logs = await SystemErrorManager.instance.getAllErrors();
    // After loading logs, emit loaded state
    emit(LogsSystemState.loaded(logs));
  }
}
