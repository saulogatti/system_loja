import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/exceptions/validation_exception.dart';
import 'package:system_loja/core/models/document/document.dart';

class Cnpj extends Document {
  /// Expressões regulares para validar o formato do CNPJ
  /// - _cnpjRegExp: Valida o formato XX.XXX.XXX/XXXX-XX
  /// - _cnpjCleanRegExp: Valida apenas os 14 dígitos numéricos
  static final RegExp _cnpjRegExp = RegExp(r'^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$');
  static final RegExp _cnpjCleanRegExp = RegExp(r'^\d{14}$');

  /// Cria uma instância de [Cnpj] com o valor informado.
  ///
  /// Lança [ValidationException] se o formato for inválido.
  Cnpj(super.value) {
    final valueCheck = super.value.trim();
    if (!_cnpjRegExp.hasMatch(valueCheck) && !_cnpjCleanRegExp.hasMatch(valueCheck)) {
      throw ValidationException(
        'CNPJ deve estar no formato XX.XXX.XXX/XXXX-XX ou conter apenas 14 dígitos',
        field: 'CNPJ',
        suggestion: 'Use o formato XX.XXX.XXX/XXXX-XX ou apenas os 14 dígitos numéricos',
        invalidValue: valueCheck,
      );
    }
  }
  @override
  String get formatted {
    final d = value.replaceAll(RegExp(r'\D'), '');
    return '${d.substring(0, 2)}.${d.substring(2, 5)}.${d.substring(5, 8)}/${d.substring(8, 12)}-${d.substring(12)}';
  }

  @override
  String? validateDocument() {
    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');

    if (cleanedValue.length != 14 || RegExp(r'^(\d)\1{13}$').hasMatch(cleanedValue)) {
      return 'CNPJ inválido - deve conter 14 dígitos e não pode ser uma sequência de números repetidos';
    }

    final digits = cleanedValue.split('').map(int.parse).toList();

    // Validação do primeiro dígito verificador
    final firstWeights = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    final sum1 = List.generate(12, (i) => digits[i] * firstWeights[i]).reduce((a, b) => a + b);
    final remainder1 = sum1 % 11;
    final checkDigit1 = remainder1 < 2 ? 0 : 11 - remainder1;

    if (checkDigit1 != digits[12]) {
      return 'CNPJ inválido - primeiro dígito verificador incorreto';
    }

    // Validação do segundo dígito verificador
    final secondWeights = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    final sum2 = List.generate(13, (i) => digits[i] * secondWeights[i]).reduce((a, b) => a + b);
    final remainder2 = sum2 % 11;
    final checkDigit2 = remainder2 < 2 ? 0 : 11 - remainder2;

    if (checkDigit2 != digits[13]) {
      return 'CNPJ inválido - segundo dígito verificador incorreto';
    }

    return null;
  }
}

class CnpjConverter extends JsonConverter<Cnpj, String> {
  const CnpjConverter();

  @override
  Cnpj fromJson(String json) => Cnpj(json);

  @override
  String toJson(Cnpj value) => value.value;
}
