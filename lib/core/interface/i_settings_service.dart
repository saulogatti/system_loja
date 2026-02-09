import 'package:system_loja/core/settings/app_theme_settings.dart';

abstract interface class ISettingsService {
 
  void updateSettings(EnumColorAppThemeSettings corPrimaria, bool temaEscuro);
}
