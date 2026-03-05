import 'package:flutter/material.dart';
import 'package:system_loja/core/interface/i_settings_service.dart';
import 'package:system_loja/core/settings/app_theme.dart';
import 'package:system_loja/core/settings/app_theme_settings.dart';

class SettingsService implements ISettingsService {
  ValueNotifier<ThemeData> currentThemeNotifier = ValueNotifier<ThemeData>(
    AppTheme.light(seedColor: EnumColorAppThemeSettings.azul.color),
  );
  ThemeData _appTheme = AppTheme.light(
    seedColor: EnumColorAppThemeSettings.azul.color,
  );
  bool _temaEscuro = false;
  SettingsService.injection();
  ThemeData get currentTheme => currentThemeNotifier.value;
  bool get temaEscuro => _temaEscuro;
  @override
  void updateSettings(EnumColorAppThemeSettings corPrimaria, bool temaEscuro) {
    if (temaEscuro) {
      _appTheme = AppTheme.dark(seedColor: corPrimaria.color);
    } else {
      _appTheme = AppTheme.light(seedColor: corPrimaria.color);
    }
    _temaEscuro = temaEscuro;
    currentThemeNotifier.value = _appTheme;
  }
  
  ValueNotifier<EnumColorAppThemeSettings> get primaryColorNotifier {
    return ValueNotifier<EnumColorAppThemeSettings>(
        currentSettings.corPrimaria);
  }
}
