import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/repository/system/log_repository.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_state_cubit.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

class LogsCubit extends Cubit<LogsState> {
  LogRepository logRepository = AppInjection.instance.logRepository;
  LogsCubit() : super(const LogsStateInitial());

  Future<void> fetchLogs() async {
    emit(const LogsLoading());
    try {
      final logs = await logRepository.fetchAllLogs();
      emit(LogsLoaded(logs));
    } catch (e) {
      emit(LogsError('Erro ao carregar logs: $e'));
    }
  }
}
