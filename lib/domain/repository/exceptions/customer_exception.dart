/// Exceção de operações de cliente no repositório.
///
/// {@category repositorios}
/// {@subCategory Cadastros}
///
/// Capturada internamente por `CustomerRepository` (try/catch) e convertida
/// em `ResultStatus.error`. Não deve vazar para a camada de apresentação.
class CustomerException extends Error {
  CustomerException(this.message);

  /// Mensagem amigável devolvida ao chamador via `ResultStatus.error`.
  final String message;

  @override
  String toString() => 'ClienteException: $message \n stackTrace: $stackTrace';
}
