import 'package:system_loja/core/settings/app_settings.dart';

abstract interface class IConfigurationRepository {
  Future<AppSettings> clearAllData();
  Future<AppSettings> clearOldLogs();
  Future<AppSettings> createBackup(String directoryPath);
  Future<AppSettings> loadConfiguration();
  Future<AppSettings> resetToDefaults();
  Future<AppSettings> restoreBackup(String direBackup);
  Future<AppSettings> updateAppSettings(AppSettings novaConfiguracao);
}
