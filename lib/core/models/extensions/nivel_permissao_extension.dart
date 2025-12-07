import '../usuario.dart';

/// Extensão para conversão entre NivelPermissao e String
///
/// Fornece métodos utilitários para converter níveis de permissão
/// para strings e vice-versa, mantendo consistência em todo o sistema.
extension NivelPermissaoExtension on NivelPermissao {
  /// Converte o nível de permissão para string
  String toStringValue() {
    switch (this) {
      case NivelPermissao.administrador:
        return 'ADMINISTRADOR';
      case NivelPermissao.usuarioComum:
        return 'USUARIO_COMUM';
    }
  }

  /// Converte o nível de permissão para texto legível
  String toDisplayName() {
    switch (this) {
      case NivelPermissao.administrador:
        return 'Administrador';
      case NivelPermissao.usuarioComum:
        return 'Usuário Comum';
    }
  }

  /// Converte uma string para NivelPermissao
  static NivelPermissao fromString(String value) {
    switch (value.toUpperCase()) {
      case 'ADMINISTRADOR':
        return NivelPermissao.administrador;
      case 'USUARIO_COMUM':
        return NivelPermissao.usuarioComum;
      default:
        return NivelPermissao.usuarioComum;
    }
  }
}
