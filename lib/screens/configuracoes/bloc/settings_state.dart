import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/settings/app_settings.dart';

part 'settings_state.freezed.dart';

/// Estados do BLoC de Configurações
@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState.error(String mensagem) = SettingsError;
  const factory SettingsState.initial() = SettingsInitialState;
  const factory SettingsState.loaded(
    AppSettings appSettings,
    SettingsSuccessStatus status,
  ) = SettingsLoadedState;
  const factory SettingsState.loading() = SettingsLoadingState;
}

enum SettingsSuccessStatus {
  deleted,
  saved,
  loaded,
  cleared,
  updated,
  backupDone,
  restoredToDefault,
  clearedOldLogs,
  backupRestored;

  String get mensagem {
    switch (this) {
      case SettingsSuccessStatus.deleted:
        return 'Dados excluídos com sucesso!';
      case SettingsSuccessStatus.saved:
        return 'Configurações salvas com sucesso!';
      case SettingsSuccessStatus.loaded:
        return 'Configurações carregadas com sucesso!';
      case SettingsSuccessStatus.cleared:
        return 'Todos os dados foram limpos com sucesso!';
      case SettingsSuccessStatus.updated:
        return 'Configurações atualizadas com sucesso!';
      case SettingsSuccessStatus.clearedOldLogs:
        return 'Logs antigos limpos com sucesso!';
      case SettingsSuccessStatus.backupDone:
        return 'Backup realizado com sucesso!';
      case SettingsSuccessStatus.restoredToDefault:
        return 'Configurações restauradas para o padrão com sucesso!';
      case SettingsSuccessStatus.backupRestored:
        return 'Backup restaurado com sucesso!';
    }
  }
}
