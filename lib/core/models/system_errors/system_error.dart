/// Erro de sistema com mensagem, código e rastreamento de pilha.
///
/// {@category modelos}
/// {@subCategory Sistema}
class SystemError {

  SystemError({
    required this.message,
    required this.code,
    required this.stackTrace,
  });
  final String message;
  final int code;

  final StackTrace stackTrace;

  @override
  String toString() => 'SystemError(code: $code, message: $message, stackTrace: $stackTrace)';
}
