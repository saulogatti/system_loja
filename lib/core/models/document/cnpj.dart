import 'dart:math';

import 'package:system_loja/core/models/document/document.dart';
import 'package:system_loja/core/utils/string_extensions.dart';

class Cnpj extends Document {
  /// Expressões regulares para validar o formato do CNPJ
  /// - _cnpjRegExp: Valida o formato XX.XXX.XXX/XXXX-XX
  /// - _cnpjCleanRegExp: Valida apenas os 14 dígitos numéricos
  static final RegExp _cnpjRegExp = RegExp(
    r'^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$',
  );
  static final RegExp _cnpjCleanRegExp = RegExp(r'^\d{14}$');

  /// Cria uma instância de [Cnpj] com o valor informado.
  ///
  /// Lança [ValidationException] se o formato ou os dígitos forem inválidos.
  Cnpj(super.value);

  @override
  String get formatted {
    final d = value.replaceAll(RegExp(r'\D'), '');
    if (d.length != 14) return value;
    return '${d.substring(0, 2)}.${d.substring(2, 5)}.${d.substring(5, 8)}/${d.substring(8, 12)}-${d.substring(12)}';
  }

  /// Gera um CNPJ matematicamente válido.
  static String generateCnpj() {
    final random = Random();
    final digits = List.generate(12, (_) => random.nextInt(10));

    // Validação do primeiro dígito verificador
    final firstWeights = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    int sum1 = 0;
    for (int i = 0; i < 12; i++) {
      sum1 += digits[i] * firstWeights[i];
    }
    final remainder1 = sum1 % 11;
    digits.add(remainder1 < 2 ? 0 : 11 - remainder1);

    // Validação do segundo dígito verificador
    final secondWeights = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    int sum2 = 0;
    for (int i = 0; i < 13; i++) {
      sum2 += digits[i] * secondWeights[i];
    }
    final remainder2 = sum2 % 11;
    digits.add(remainder2 < 2 ? 0 : 11 - remainder2);

    return digits.join();
  }

  @override
  String? validateDocument() {
    final valueCheck = value.trim();
    if (!_cnpjRegExp.hasMatch(valueCheck) &&
        !_cnpjCleanRegExp.hasMatch(valueCheck)) {
      return 'CNPJ deve estar no formato XX.XXX.XXX/XXXX-XX ou conter apenas 14 dígitos';
    }

    if (!valueCheck.isValidCnpj()) {
      return 'CNPJ inválido - dígitos verificadores incorretos ou sequência repetida';
    }

    return null;
  }

  static Cnpj defaultObject() => Cnpj('00.000.000/0001-91');
}
