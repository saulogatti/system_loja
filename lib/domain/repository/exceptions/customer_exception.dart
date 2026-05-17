class CustomerException extends Error {
  final String message;
  CustomerException(this.message);

  @override
  String toString() => 'ClienteException: $message \n stackTrace: $stackTrace';
}
