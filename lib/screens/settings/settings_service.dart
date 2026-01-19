import 'package:flutter/material.dart';
import 'package:system_loja/core/settings/app_settings.dart';

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  ValueNotifier<ThemeData> primaryColorNotifier = ValueNotifier<ThemeData>(
    ThemeData(useMaterial3: true),
  );
  ThemeData _appTheme = ThemeData(useMaterial3: true);
  factory SettingsService() => _instance;
  SettingsService._internal();
  ThemeData get appTheme => _appTheme;

  AppSettings get currentSettings {
    // Return current settings; placeholder implementation
    return AppSettings.createDefaultSettings();
  }

  void updateSettings(AppSettings newSettings) {
    _appTheme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: newSettings.corPrimaria.color,
        brightness: newSettings.temaEscuro ? Brightness.dark : Brightness.light,
      ),
      useMaterial3: true,
      textTheme: newSettings.temaEscuro
          ? ThemeData.dark().textTheme
          : ThemeData.light().textTheme,
    );
    primaryColorNotifier.value = _appTheme;
  }
}
