import 'package:system_loja/core/models/document/document.dart';
import 'package:system_loja/core/utils/string_extensions.dart';

class Cpf extends Document {
  /// Expressões regulares para validar o formato do CPF
  /// - _cpfRegExp: Valida o formato XXX.XXX.XXX-XX
  /// - _cpfCleanRegExp: Valida apenas os 11 dígitos numéricos
  static final RegExp _cpfRegExp = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
  static final RegExp _cpfCleanRegExp = RegExp(r'^\d{11}$');

  /// Cria uma instância de [Cpf] com o valor informado.
  ///
  /// Lança [ValidationException] se o formato ou os dígitos forem inválidos.
  Cpf(super.value);

  @override
  String get formatted {
    final d = value.replaceAll(RegExp(r'\D'), '');
    if (d.length != 11) return value;
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
      return 'CPF deve estar no formato XXX.XXX.XXX-XX ou conter apenas 11 dígitos';
    }

    if (!valueCheck.isValidCpf()) {
      return 'CPF inválido - dígitos verificadores incorretos ou sequência repetida';
    }

    return null;
  }

  static Cpf defaultObject() => Cpf('123.456.789-09');
}
