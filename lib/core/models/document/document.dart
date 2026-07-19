import 'package:system_loja/core/exceptions/validation_exception.dart';

abstract class Document {

  Document(this.value) {
    final validationError = validateDocument();
    if (validationError != null) {
      throw ValidationException(validationError);
    }
  }
  final String value;

  String get formatted;
  String? validateDocument();
}
