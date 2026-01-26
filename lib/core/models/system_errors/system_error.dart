import 'package:system_loja/data/cache/models/system_model/system_error_model.dart';

class SystemError {
  final String message;
  final int code;
  @StackTraceConverter()
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
