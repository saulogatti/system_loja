import 'dart:async';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_configuration_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';

import 'settings_event.dart';
import 'settings_state.dart';

/// BLoC para gerenciar o estado das configurações do sistema.
///
/// Erros vindos do repositório já chegam como [ResultStatus.error]; este BLoC
/// apenas mapeia para [SettingsState]. `try/catch` fica limitado a fluxo de
/// seleção de diretório quando a plataforma lança exceção.
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

  Future<void> _onClearAllData(
    ClearAllDataEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    final result = await _configurationRepository.clearAllData();
    switch (result) {
      case ResultSuccess(:final result):
        emit(SettingsLoadedState(result, SettingsSuccessStatus.cleared));
      case ResultError(:final resultError):
        emit(SettingsError(resultError));
    }
  }

  Future<void> _onClearOldLogs(
    ClearOldLogsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    final result = await _configurationRepository.clearOldLogs();
    switch (result) {
      case ResultSuccess(:final result):
        emit(SettingsLoadedState(result, SettingsSuccessStatus.clearedOldLogs));
      case ResultError(:final resultError):
        emit(SettingsError(resultError));
    }
  }

  Future<void> _onCreateBackup(
    BackupSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final directoryPath = await getDirectoryPath(canCreateDirectories: true);
      if (directoryPath == null) {
        emit(SettingsError('Nenhum diretório selecionado para backup.'));
        return;
      }

      final result = await _configurationRepository.createBackup(directoryPath);
      switch (result) {
        case ResultSuccess(:final result):
          emit(SettingsLoadedState(result, SettingsSuccessStatus.backupDone));
        case ResultError(:final resultError):
          emit(SettingsError(resultError));
      }
    } catch (e) {
      emit(
        SettingsError('Erro ao selecionar diretório ou realizar backup: $e'),
      );
    }
  }

  Future<void> _onLoadSettings(
    LoadSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    final result = await _configurationRepository.loadConfiguration();
    switch (result) {
      case ResultSuccess(:final result):
        emit(SettingsLoadedState(result, SettingsSuccessStatus.loaded));
      case ResultError(:final resultError):
        emit(SettingsError(resultError));
    }
  }

  Future<void> _onResetToDefault(
    ResetDefaultSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    final resetResult = await _configurationRepository.resetToDefaults();
    switch (resetResult) {
      case ResultError(:final resultError):
        emit(SettingsError(resultError));
        return;
      case ResultSuccess():
        break;
    }
    final loadResult = await _configurationRepository.loadConfiguration();
    switch (loadResult) {
      case ResultSuccess(:final result):
        emit(
          SettingsLoadedState(result, SettingsSuccessStatus.restoredToDefault),
        );
      case ResultError(:final resultError):
        emit(SettingsError(resultError));
    }
  }

  FutureOr<void> _onRestoreBackup(
    RestoreBackupEvent event,
    Emitter<SettingsState> emit,
  ) async {
    String? direBackup;
    try {
      direBackup = await getDirectoryPath();
    } catch (e) {
      emit(SettingsError('Erro ao selecionar diretório de backup: $e'));
      return;
    }
    if (direBackup == null) {
      emit(
        SettingsError('Nenhum diretório selecionado para restaurar o backup.'),
      );
      return;
    }
    emit(const SettingsLoadingState());
    final result = await _configurationRepository.restoreBackup(direBackup);
    switch (result) {
      case ResultSuccess(:final result):
        emit(SettingsLoadedState(result, SettingsSuccessStatus.backupRestored));
      case ResultError(:final resultError):
        emit(SettingsError(resultError));
    }
  }

  Future<void> _onUpdateSettings(
    UpdateSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    final result = await _configurationRepository.updateAppSettings(
      event.appSettings,
    );
    switch (result) {
      case ResultSuccess(:final result):
        emit(SettingsLoadedState(result, SettingsSuccessStatus.updated));
      case ResultError(:final resultError):
        emit(SettingsError(resultError));
    }
  }
}
