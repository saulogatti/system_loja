import 'package:system_loja/core/settings/app_settings.dart';

/// Evento para realizar backup dos dados
class BackupSettingsEvent extends SettingsEvent {
  const BackupSettingsEvent();
}

/// Evento para limpar todos os dados do sistema
class ClearAllDataEvent extends SettingsEvent {
  const ClearAllDataEvent();
}

/// Evento para limpar logs antigos
class ClearOldLogsEvent extends SettingsEvent {
  const ClearOldLogsEvent();
}

/// Evento para carregar as configurações iniciais
class LoadSettingsEvent extends SettingsEvent {
  const LoadSettingsEvent();
}

/// Evento para restaurar configurações padrão
class ResetDefaultSettingsEvent extends SettingsEvent {
  const ResetDefaultSettingsEvent();
}

/// Eventos do BLoC de Configurações
abstract class SettingsEvent {
  const SettingsEvent();
}

/// Evento para atualizar as configurações
class UpdateSettingsEvent extends SettingsEvent {
  /// Nova configuração a ser aplicada
  final AppSettings appSettings;

  const UpdateSettingsEvent(this.appSettings);
}
