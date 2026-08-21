/// Exceção lançada quando a validação de documento (CPF/CNPJ) falha.
///
/// {@category utilitarios}
class DocumentException implements Exception {

  DocumentException({
    required this.message,
    required this.field,
    required this.suggestion,
  });
  final String message;
  final String field;
  final String suggestion;

  @override
  String toString() => 'DocumentException: $message';
}
