import 'package:flutter/material.dart';
import 'package:system_loja/core/settings/app_theme_settings.dart';

class SettingsService {
  ValueNotifier<ThemeData> currentThemeNotifier = ValueNotifier<ThemeData>(
    ThemeData(useMaterial3: true),
  );
  ThemeData _appTheme = ThemeData(useMaterial3: true);
  bool _temaEscuro = false;
  SettingsService.injection();
  ThemeData get currentTheme => currentThemeNotifier.value;
  bool get temaEscuro => _temaEscuro;
  void updateSettings(EnumColorAppThemeSettings corPrimaria, bool temaEscuro) {
    _appTheme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: corPrimaria.color,
        brightness: temaEscuro ? Brightness.dark : Brightness.light,
      ),
      useMaterial3: true,
      textTheme: temaEscuro
          ? ThemeData.dark().textTheme
          : ThemeData.light().textTheme,
    );
    _temaEscuro = temaEscuro;
    currentThemeNotifier.value = _appTheme;
  }
}
