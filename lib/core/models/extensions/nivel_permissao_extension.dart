import 'package:system_loja/core/models/default/authorization_level.dart';

/// Extensão para conversão entre NivelPermissao e String
///
/// Fornece métodos utilitários para converter níveis de permissão
/// para strings e vice-versa, mantendo consistência em todo o sistema.
extension NivelPermissaoExtension on AuthorizationLevel {
  /// Converte o nível de permissão para texto legível
  String toDisplayName() {
    switch (this) {
      case AuthorizationLevel.administrador:
        return 'Administrador';
      case AuthorizationLevel.usuarioComum:
        return 'Usuário Comum';
    }
  }

  /// Converte o nível de permissão para string
  String toStringValue() {
    switch (this) {
      case AuthorizationLevel.administrador:
        return 'ADMINISTRADOR';
      case AuthorizationLevel.usuarioComum:
        return 'USUARIO_COMUM';
    }
  }

  /// Converte uma string para NivelPermissao
  static AuthorizationLevel fromString(String value) {
    switch (value.toUpperCase()) {
      case 'ADMINISTRADOR':
        return AuthorizationLevel.administrador;
      case 'USUARIO_COMUM':
        return AuthorizationLevel.usuarioComum;
      default:
        return AuthorizationLevel.usuarioComum;
    }
  }
}
