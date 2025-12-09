
import 'package:system_loja/core/settings/settings_app.dart';

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();
  SettingsApp get currentSettings {
    // Return current settings; placeholder implementation
    return SettingsApp(typeCache: EnumTypeCache.json);
  }
}