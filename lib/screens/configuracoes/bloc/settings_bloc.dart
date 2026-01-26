import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

import 'settings_event.dart';
import 'settings_state.dart';

/// BLoC para gerenciar o estado das configurações do sistema
///
/// Utiliza o ConfiguracaoManager para persistência de dados
/// e gerencia os estados da tela de configurações.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsInitialState()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<UpdateSettingsEvent>(_onUpdateSettings);
    on<ResetDefaultSettingsEvent>(_onResetToDefault);
    on<BackupSettingsEvent>(_onCreateBackup);
    on<ClearOldLogsEvent>(_onClearOldLogs);
    on<ClearAllDataEvent>(_onClearAllData);
  }

  /// Limpa todos os dados do sistema
  Future<void> _onClearAllData(
    ClearAllDataEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final sucesso = await AppInjection.instance.configurationRepository
          .clearAllData();

      emit(SettingsLoadedState(sucesso, SettingsSuccessStatus.cleared));
    } catch (e) {
      emit(SettingsError('Erro ao limpar dados: $e'));
    }
  }

  /// Limpa logs antigos baseado na configuração
  Future<void> _onClearOldLogs(
    ClearOldLogsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final sucesso = await AppInjection.instance.configurationRepository
          .clearOldLogs();

      emit(SettingsLoadedState(sucesso, SettingsSuccessStatus.clearedOldLogs));
    } catch (e) {
      emit(SettingsError('Erro ao limpar logs: $e'));
    }
  }

  /// Realiza backup dos dados do sistema
  Future<void> _onCreateBackup(
    BackupSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final sucesso = await AppInjection.instance.configurationRepository
          .createBackup();

      emit(SettingsLoadedState(sucesso, SettingsSuccessStatus.backupDone));
    } catch (e) {
      emit(SettingsError('Erro ao realizar backup: $e'));
    }
  }

  /// Carrega as configurações iniciais
  Future<void> _onLoadSettings(
    LoadSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final configuracao = await AppInjection.instance.configurationRepository
          .loadConfiguration();
      emit(SettingsLoadedState(configuracao, SettingsSuccessStatus.loaded));
    } catch (e) {
      emit(SettingsError('Erro ao carregar configurações: $e'));
    }
  }

  /// Restaura as configurações para valores padrão
  Future<void> _onResetToDefault(
    ResetDefaultSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      await AppInjection.instance.configurationRepository.resetToDefaults();
      final configuracao = await AppInjection.instance.configurationRepository
          .loadConfiguration();

      emit(
        SettingsLoadedState(
          configuracao,
          SettingsSuccessStatus.restoredToDefault,
        ),
      );
    } catch (e) {
      emit(SettingsError('Erro ao restaurar configurações: $e'));
    }
  }

  /// Atualiza as configurações do sistema
  Future<void> _onUpdateSettings(
    UpdateSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final updatedSettings = await AppInjection
          .instance
          .configurationRepository
          .updateAppSettings(event.appSettings);
      emit(SettingsLoadedState(updatedSettings, SettingsSuccessStatus.updated));
    } catch (e) {
      emit(SettingsError('Erro ao salvar configurações: $e'));
    }
  }
}
