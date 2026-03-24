class SystemError {
  final String message;
  final int code;

  final StackTrace stackTrace;

  SystemError({
    required this.message,
    required this.code,
    required this.stackTrace,
  });

  @override
  String toString() {
    return 'SystemError(code: $code, message: $message, stackTrace: $stackTrace)';
  }
}
