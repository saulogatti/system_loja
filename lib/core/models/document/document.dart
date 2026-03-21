import 'package:system_loja/core/exceptions/validation_exception.dart';

abstract class Document {
  final String value;

  Document(this.value) {
    final validationError = validateDocument();
    if (validationError != null) {
      throw ValidationException(validationError);
    }
  }

  String get formatted;
  String? validateDocument();
}
