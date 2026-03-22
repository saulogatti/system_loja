import 'package:system_loja/core/exceptions/validation_exception.dart';
import 'package:system_loja/core/models/document/document.dart';

class Cpf extends Document {
  /// Expressões regulares para validar o formato do CPF
  /// - _cpfRegExp: Valida o formato XXX.XXX.XXX-XX
  /// - _cpfCleanRegExp: Valida apenas os 11 dígitos numéricos
  static final RegExp _cpfRegExp = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
  static final RegExp _cpfCleanRegExp = RegExp(r'^\d{11}$');
  Cpf(super.value) {
    if (validateDocument() != null) {
      throw ValidationException(
        'CPF deve estar no formato XXX.XXX.XXX-XX ou conter apenas 11 dígitos',
        field: 'CPF',
        suggestion:
            'Use o formato XXX.XXX.XXX-XX ou apenas os 11 dígitos numéricos',
        invalidValue: value,
      );
    }
  }

  @override
  String get formatted {
    final d = value.replaceAll(RegExp(r'\D'), '');
    return '${d.substring(0, 3)}.${d.substring(3, 6)}.${d.substring(6, 9)}-${d.substring(9)}';
  }

  @override
  String? validateDocument() {
    final valueCheck = value.trim();
    if (valueCheck == '123.456.789-09') {
      return null;
    }
    if (!_cpfRegExp.hasMatch(valueCheck) &&
        !_cpfCleanRegExp.hasMatch(valueCheck)) {
      return ('CPF deve estar no formato XXX.XXX.XXX-XX ou conter apenas 11 dígitos');
    }
    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');

    if (cleanedValue.length != 11 ||
        RegExp(r'^(\d)\1{10}$').hasMatch(cleanedValue)) {
      return 'CPF inválido - deve conter 11 dígitos e não pode ser uma sequência de números repetidos';
    }

    final digits = cleanedValue.split('').map(int.parse).toList();

    // Validação do primeiro dígito verificador
    final sum1 = List.generate(
      9,
      (i) => digits[i] * (10 - i),
    ).reduce((a, b) => a + b);
    final checkDigit1 = (sum1 * 10 % 11) % 10;

    if (checkDigit1 != digits[9]) {
      return 'CPF inválido - primeiro dígito verificador incorreto';
    }

    // Validação do segundo dígito verificador
    final sum2 = List.generate(
      10,
      (i) => digits[i] * (11 - i),
    ).reduce((a, b) => a + b);
    final checkDigit2 = (sum2 * 10 % 11) % 10;

    if (checkDigit2 != digits[10]) {
      return 'CPF inválido - segundo dígito verificador incorreto';
    }

    return null;
  }

  static Cpf defaultObject() => Cpf('123.456.789-09');
}
