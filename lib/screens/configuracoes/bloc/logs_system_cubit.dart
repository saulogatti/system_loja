import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_system_error_manager.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_system_state.dart';

class LogsSystemCubit extends Cubit<LogsSystemState> {
  final ISystemErrorManager _systemErrorManager;

  LogsSystemCubit(this._systemErrorManager) : super(const LogsSystemState.initial());

  Future<void> clearLogs() async {
    emit(const LogsSystemState.loading());
    try {
      await _systemErrorManager.clearAllErrors();
      emit(const LogsSystemState.deleted());
    } catch (_) {
      emit(const LogsSystemState.error('Falha ao limpar logs do sistema.'));
    }
  }

  Future<void> loadLogs() async {
    emit(const LogsSystemState.loading());
    try {
      final logs = await _systemErrorManager.getAllErrors();
      emit(LogsSystemState.loaded(logs));
    } catch (_) {
      emit(const LogsSystemState.error('Falha ao carregar logs do sistema.'));
    }
  }
}
