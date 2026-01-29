import 'dart:async';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/managers/configuration_repository.dart';

import 'settings_event.dart';
import 'settings_state.dart';

/// BLoC para gerenciar o estado das configurações do sistema
///
/// Utiliza o ConfiguracaoManager para persistência de dados
/// e gerencia os estados da tela de configurações.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ConfigurationRepository _configurationRepository =
      ConfigurationRepository();
  SettingsBloc() : super(const SettingsInitialState()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<UpdateSettingsEvent>(_onUpdateSettings);
    on<ResetDefaultSettingsEvent>(_onResetToDefault);
    on<BackupSettingsEvent>(_onCreateBackup);
    on<ClearOldLogsEvent>(_onClearOldLogs);
    on<ClearAllDataEvent>(_onClearAllData);
    on<RestoreBackupEvent>(_onRestoreBackup);
  }

  /// Limpa todos os dados do sistema
  Future<void> _onClearAllData(
    ClearAllDataEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final sucesso = await _configurationRepository.clearAllData();

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
      final sucesso = await _configurationRepository.clearOldLogs();

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
      final file = await getDirectoryPath(canCreateDirectories: true);
      if (file == null) {
        emit(SettingsError('Nenhum diretório selecionado para backup.'));
        return;
      }

      final sucesso = await _configurationRepository.createBackup(file);

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
      final configuracao = await _configurationRepository.loadConfiguration();
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
      await _configurationRepository.resetToDefaults();
      final configuracao = await _configurationRepository.loadConfiguration();

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

  FutureOr<void> _onRestoreBackup(
    RestoreBackupEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final direBackup = await getDirectoryPath();
    if (direBackup == null) {
      emit(
        SettingsError('Nenhum diretório selecionado para restaurar o backup.'),
      );
      return;
    }
    emit(const SettingsLoadingState());
    try {
      final sucesso = await _configurationRepository.restoreBackup(direBackup);

      emit(SettingsLoadedState(sucesso, SettingsSuccessStatus.backupRestored));
    } catch (e) {
      emit(SettingsError('Erro ao restaurar backup: $e'));
    }
  }

  /// Atualiza as configurações do sistema
  Future<void> _onUpdateSettings(
    UpdateSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final updatedSettings = await _configurationRepository.updateAppSettings(
        event.appSettings,
      );
      emit(SettingsLoadedState(updatedSettings, SettingsSuccessStatus.updated));
    } catch (e) {
      emit(SettingsError('Erro ao salvar configurações: $e'));
    }
  }
}
