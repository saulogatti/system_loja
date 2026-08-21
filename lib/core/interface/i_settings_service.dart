import 'package:system_loja/core/settings/enum_color_app_theme_settings.dart';

/// Contrato de tema da aplicação (cor primária e modo claro/escuro).
///
/// {@category contratos}
/// {@subCategory Sistema}
///
/// Notifica listeners para atualizar a UI. Persistência das preferências
/// fica em [IConfigurationRepository].
///
/// Resolver com `appInjection.get<ISettingsService>()`.
///
/// ```dart
/// final service = appInjection.get<ISettingsService>();
/// service.updateSettings(EnumColorAppThemeSettings.blue, temaEscuro: true);
/// ```
///
/// Veja também:
/// - [EnumColorAppThemeSettings] — paleta disponível
abstract interface class ISettingsService {
  /// Atualiza as configurações de tema da aplicação.
  ///
  /// As mudanças são aplicadas imediatamente e notificam todos os
  /// listeners para atualização da interface.
  ///
  /// Parâmetros:
  /// - [corPrimaria]: Cor primária do tema (blue, green, red, etc.)
  /// - [temaEscuro]: Define se o tema escuro está ativo (true) ou tema claro (false)
  void updateSettings(EnumColorAppThemeSettings corPrimaria, {bool temaEscuro = false});
}
