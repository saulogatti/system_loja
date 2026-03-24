class DocumentException implements Exception {
  final String message;
  final String field;
  final String suggestion;

  DocumentException({
    required this.message,
    required this.field,
    required this.suggestion,
  });

  @override
  String toString() => 'DocumentException: $message';
}
