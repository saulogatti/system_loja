class CustomerException extends Error {
  CustomerException(this.message);
  final String message;

  @override
  String toString() => 'ClienteException: $message \n stackTrace: $stackTrace';
}
