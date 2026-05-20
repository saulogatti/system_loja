import 'package:system_loja/core/settings/enum_color_app_theme_settings.dart';

/// Interface que define o contrato para serviço de configurações de tema.
///
/// Esta interface gerencia as configurações visuais da aplicação,
/// como cor primária e modo escuro/claro.
///
/// Diferente dos repositories, este serviço não persiste dados diretamente,
/// mas notifica listeners para atualização da UI em tempo real.
///
/// Exemplo de uso:
/// ```dart
/// final service = appInjection.get<SettingsService>();
///
/// // Atualizar para tema escuro com cor azul
/// service.updateSettings(
///   EnumColorAppThemeSettings.blue,
///   true, // tema escuro
/// );
/// ```
///
/// Veja também:
/// - [EnumColorAppThemeSettings] - enum com cores disponíveis
abstract interface class ISettingsService {
  /// Atualiza as configurações de tema da aplicação.
  ///
  /// As mudanças são aplicadas imediatamente e notificam todos os
  /// listeners para atualização da interface.
  ///
  /// Parâmetros:
  /// - [corPrimaria]: Cor primária do tema (blue, green, red, etc.)
  /// - [temaEscuro]: Define se o tema escuro está ativo (true) ou tema claro (false)
  void updateSettings(EnumColorAppThemeSettings corPrimaria, bool temaEscuro);
}
