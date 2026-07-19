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
