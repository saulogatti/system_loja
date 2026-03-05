import '../activity_log.dart';

/// Extensão para conversão entre TipoAcao e String
///
/// Fornece métodos utilitários para converter tipos de ação
/// para strings e vice-versa, mantendo consistência em todo o sistema.
extension TipoAcaoExtension on ActionType {
  /// Converte o tipo de ação para texto legível
  String toDisplayName() {
    switch (this) {
      case ActionType.criar:
        return 'Criação';
      case ActionType.ler:
        return 'Leitura';
      case ActionType.atualizar:
        return 'Atualização';
      case ActionType.deletar:
        return 'Exclusão';
    }
  }

  /// Converte o tipo de ação para string
  String toStringValue() {
    switch (this) {
      case ActionType.criar:
        return 'CRIAR';
      case ActionType.ler:
        return 'LER';
      case ActionType.atualizar:
        return 'ATUALIZAR';
      case ActionType.deletar:
        return 'DELETAR';
    }
  }

  /// Converte uma string para TipoAcao
  static ActionType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'CRIAR':
        return ActionType.criar;
      case 'LER':
        return ActionType.ler;
      case 'ATUALIZAR':
        return ActionType.atualizar;
      case 'DELETAR':
        return ActionType.deletar;
      default:
        return ActionType.criar;
    }
  }
}
