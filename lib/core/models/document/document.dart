import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/exceptions/document_exception.dart';
import 'package:system_loja/core/exceptions/validation_exception.dart';
import 'package:system_loja/core/models/document/cnpj.dart';
import 'package:system_loja/core/models/document/cpf.dart';

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

class DocumentConverter extends JsonConverter<Document, String> {
  const DocumentConverter();

  @override
  Document fromJson(String json) {
    final digits = json.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 11) return Cpf(digits);
    if (digits.length == 14) return Cnpj(digits);
    throw DocumentException(
      message: 'Invalid document: $digits',
      field: 'document',
      suggestion: 'Use the format XXX.XXX.XXX-XX or only 11 digits',
    );
  }

  @override
  String toJson(Document value) => value.formatted;
}
