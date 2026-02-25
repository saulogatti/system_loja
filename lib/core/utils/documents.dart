import 'package:system_loja/screens/person_registration/models/person_registration_form_data.dart';

/// Representa um documento CNPJ e valida seu formato na criação.
///
/// Aceita valores no formato `XX.XXX.XXX/XXXX-XX` ou contendo apenas
/// 14 dígitos numéricos.
class Cnpj extends Documents {
  static final RegExp _cnpjRegExp = RegExp(r'^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$');
  static final RegExp _cnpjCleanRegExp = RegExp(r'^\d{14}$');

  /// Cria uma instância de [Cnpj] com o valor informado.
  ///
  /// Lança [ArgumentError] se o formato for inválido.
  Cnpj(super.value) {
    value = value.trim();
    if (!_cnpjRegExp.hasMatch(value) && !_cnpjCleanRegExp.hasMatch(value)) {
      throw ArgumentError('CNPJ deve estar no formato XX.XXX.XXX/XXXX-XX ou conter apenas 14 dígitos');
    }
  }

  /// Valida o número de CNPJ informado.
  ///
  /// Retorna `null` quando o CNPJ é válido. Retorna uma mensagem de erro
  /// descritiva quando o valor é inválido.
  static String? isValidCNPJ(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');

    if (cleanedValue.length != 14 || RegExp(r'^(\d)\1{13}$').hasMatch(cleanedValue)) {
      return 'CNPJ inválido - deve conter 14 dígitos e não pode ser uma sequência de números repetidos';
    }

    final digits = cleanedValue.split('').map(int.parse).toList();

    // Validação do primeiro dígito verificador
    final sum1 = List.generate(12, (i) => digits[i] * (5 - i % 8)).reduce((a, b) => a + b);
    final checkDigit1 = (sum1 * 10 % 11) % 10;

    if (checkDigit1 != digits[12]) {
      return 'CNPJ inválido - primeiro dígito verificador incorreto';
    }

    // Validação do segundo dígito verificador
    final sum2 = List.generate(13, (i) => digits[i] * (6 - i % 8)).reduce((a, b) => a + b);
    final checkDigit2 = (sum2 * 10 % 11) % 10;

    if (checkDigit2 != digits[13]) {
      return 'CNPJ inválido - segundo dígito verificador incorreto';
    }

    return null;
  }
}

/// Representa um documento CPF e valida seu formato na criação.
///
/// Aceita valores no formato `XXX.XXX.XXX-XX` ou contendo apenas
/// 11 dígitos numéricos.
class Cpf extends Documents {
  static final RegExp _cpfRegExp = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
  static final RegExp _cpfCleanRegExp = RegExp(r'^\d{11}$');

  /// Cria uma instância de [Cpf] com o valor informado.
  ///
  /// Lança [ArgumentError] se o formato for inválido.
  Cpf(super.value) {
    value = value.trim();
    if (!_cpfRegExp.hasMatch(value) && !_cpfCleanRegExp.hasMatch(value)) {
      throw ArgumentError('CPF deve estar no formato XXX.XXX.XXX-XX ou conter apenas 11 dígitos');
    }
  }

  /// Valida o número de CPF informado.
  ///
  /// Retorna `null` quando o CPF é válido. Retorna uma mensagem de erro
  /// descritiva quando o valor é inválido.
  static String? isValidCPF(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');

    if (cleanedValue.length != 11 || RegExp(r'^(\d)\1{10}$').hasMatch(cleanedValue)) {
      return 'CPF inválido - deve conter 11 dígitos e não pode ser uma sequência de números repetidos';
    }

    final digits = cleanedValue.split('').map(int.parse).toList();

    // Validação do primeiro dígito verificador
    final sum1 = List.generate(9, (i) => digits[i] * (10 - i)).reduce((a, b) => a + b);
    final checkDigit1 = (sum1 * 10 % 11) % 10;

    if (checkDigit1 != digits[9]) {
      return 'CPF inválido - primeiro dígito verificador incorreto';
    }

    // Validação do segundo dígito verificador
    final sum2 = List.generate(10, (i) => digits[i] * (11 - i)).reduce((a, b) => a + b);
    final checkDigit2 = (sum2 * 10 % 11) % 10;

    if (checkDigit2 != digits[10]) {
      return 'CPF inválido - segundo dígito verificador incorreto';
    }

    return null;
  }
}

/// Define comportamentos compartilhados para validação de documentos.
abstract class Documents {
  /// Armazena o valor bruto do documento informado.
  late String value;

  /// Inicializa a classe base com o [value] do documento.
  Documents(this.value);

  /// Valida o documento de acordo com o [selectedPersonType].
  ///
  /// Retorna `null` quando o documento é válido. Retorna mensagem de erro
  /// quando o valor é nulo, vazio ou inválido para o tipo selecionado.
  static String? validateDocument({required String? value, required PersonType selectedPersonType}) {
    if (value == null || value.trim().isEmpty) {
      return '${selectedPersonType.documentLabel} é obrigatório';
    }

    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');

    if (selectedPersonType == PersonType.individual) {
      return Cpf.isValidCPF(cleanedValue);
    } else {
      return Cnpj.isValidCNPJ(cleanedValue);
    }
  }
}
