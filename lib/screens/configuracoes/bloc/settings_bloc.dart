import 'dart:async';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_configuration_repository.dart';
import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/core/utils/command_result.dart';

import 'settings_event.dart';
import 'settings_state.dart';

/// BLoC para gerenciar o estado das configurações do sistema
///
/// Utiliza o ConfiguracaoManager para persistência de dados
/// e gerencia os estados da tela de configurações.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final IConfigurationRepository _configurationRepository;

  SettingsBloc({required IConfigurationRepository configurationRepository})
    : _configurationRepository = configurationRepository,
      super(const SettingsInitialState()) {
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
    final result = await _configurationRepository.clearAllData();
    _emitResult(
      emit: emit,
      result: result,
      successStatus: SettingsSuccessStatus.cleared,
    );
  }

  /// Limpa logs antigos baseado na configuração
  Future<void> _onClearOldLogs(
    ClearOldLogsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    final result = await _configurationRepository.clearOldLogs();
    _emitResult(
      emit: emit,
      result: result,
      successStatus: SettingsSuccessStatus.clearedOldLogs,
    );
  }

  /// Realiza backup dos dados do sistema
  Future<void> _onCreateBackup(
    BackupSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    final file = await getDirectoryPath(canCreateDirectories: true);
    if (file == null) {
      emit(SettingsError('Nenhum diretório selecionado para backup.'));
      return;
    }
    final result = await _configurationRepository.createBackup(file);
    _emitResult(
      emit: emit,
      result: result,
      successStatus: SettingsSuccessStatus.backupDone,
    );
  }

  /// Carrega as configurações iniciais
  Future<void> _onLoadSettings(
    LoadSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    final result = await _configurationRepository.loadConfiguration();
    _emitResult(
      emit: emit,
      result: result,
      successStatus: SettingsSuccessStatus.loaded,
    );
  }

  /// Restaura as configurações para valores padrão
  Future<void> _onResetToDefault(
    ResetDefaultSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    final result = await _configurationRepository.resetToDefaults();
    _emitResult(
      emit: emit,
      result: result,
      successStatus: SettingsSuccessStatus.restoredToDefault,
    );
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
    final result = await _configurationRepository.restoreBackup(direBackup);
    _emitResult(
      emit: emit,
      result: result,
      successStatus: SettingsSuccessStatus.backupRestored,
    );
  }

  /// Atualiza as configurações do sistema
  Future<void> _onUpdateSettings(
    UpdateSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    final result = await _configurationRepository.updateAppSettings(
      event.appSettings,
    );
    _emitResult(
      emit: emit,
      result: result,
      successStatus: SettingsSuccessStatus.updated,
    );
  }

  void _emitResult({
    required Emitter<SettingsState> emit,
    required ResultStatus<AppSettings, String> result,
    required SettingsSuccessStatus successStatus,
  }) {
    result.when(
      onSuccess: (settings) {
        emit(SettingsLoadedState(settings, successStatus));
      },
      onError: (errorMessage) {
        emit(SettingsError(errorMessage));
      },
    );
  }
}
