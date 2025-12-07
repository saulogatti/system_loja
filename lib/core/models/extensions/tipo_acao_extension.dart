import '../log_atividade.dart';

/// Extensão para conversão entre TipoAcao e String
///
/// Fornece métodos utilitários para converter tipos de ação
/// para strings e vice-versa, mantendo consistência em todo o sistema.
extension TipoAcaoExtension on TipoAcao {
  /// Converte o tipo de ação para string
  String toStringValue() {
    switch (this) {
      case TipoAcao.criar:
        return 'CRIAR';
      case TipoAcao.ler:
        return 'LER';
      case TipoAcao.atualizar:
        return 'ATUALIZAR';
      case TipoAcao.deletar:
        return 'DELETAR';
    }
  }

  /// Converte o tipo de ação para texto legível
  String toDisplayName() {
    switch (this) {
      case TipoAcao.criar:
        return 'Criação';
      case TipoAcao.ler:
        return 'Leitura';
      case TipoAcao.atualizar:
        return 'Atualização';
      case TipoAcao.deletar:
        return 'Exclusão';
    }
  }

  /// Converte uma string para TipoAcao
  static TipoAcao fromString(String value) {
    switch (value.toUpperCase()) {
      case 'CRIAR':
        return TipoAcao.criar;
      case 'LER':
        return TipoAcao.ler;
      case 'ATUALIZAR':
        return TipoAcao.atualizar;
      case 'DELETAR':
        return TipoAcao.deletar;
      default:
        return TipoAcao.criar;
    }
  }
}
