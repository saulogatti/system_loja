import 'package:flutter/foundation.dart';
import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/core/settings/app_theme_settings.dart';

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();
  AppSettings get currentSettings {
    // Return current settings; placeholder implementation
    return AppSettings.createDefaultSettings();
  }
  ValueNotifier<EnumColorAppThemeSettings> get primaryColorNotifier {
    return ValueNotifier<EnumColorAppThemeSettings>(
        currentSettings.corPrimaria);
  }
}
