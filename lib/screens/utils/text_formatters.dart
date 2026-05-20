import 'package:flutter/services.dart';
import 'package:system_loja/core/constants/app_constants.dart';

/// Formatador de CNPJ para campos de texto
///
/// Aplica a máscara XX.XXX.XXX/XXXX-XX automaticamente enquanto o usuário digita.
/// Remove automaticamente caracteres não-numéricos e limita a 14 dígitos.
///
/// **Uso recomendado**: Formulário de cadastro de empresa (company_form.dart)
/// para permitir entrada formatada de CNPJ durante o registro.
class CnpjTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // se oldValue é maior que newValue, significa que o usuário está apagando
    if (oldValue.text.length > newValue.text.length) {
      return newValue;
    }
    // Remove todos os caracteres não-numéricos
    final digitsOnly = newValue.text.replaceAll(Constants.nonNumericRegExp, '');

    // Limita a 14 dígitos
    final limitedDigits = digitsOnly.length > 14
        ? digitsOnly.substring(0, 14)
        : digitsOnly;

    // Aplica a formatação
    final formatted = _formatCnpj(limitedDigits);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  /// Formata uma string de dígitos no padrão XX.XXX.XXX/XXXX-XX
  String _formatCnpj(String digits) {
    if (digits.isEmpty) return '';

    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if (i == 1 || i == 4) {
        buffer.write('.');
      } else if (i == 7) {
        buffer.write('/');
      } else if (i == 11) {
        buffer.write('-');
      }
    }

    return buffer.toString();
  }
}

/// Formatador de CPF para campos de texto
///
/// Aplica a máscara XXX.XXX.XXX-XX automaticamente enquanto o usuário digita.
/// Remove automaticamente caracteres não-numéricos e limita a 11 dígitos.
class CpfTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // se oldValue é maior que newValue, significa que o usuário está apagando
    if (oldValue.text.length > newValue.text.length) {
      return newValue;
    }
    // Remove todos os caracteres não-numéricos
    final digitsOnly = newValue.text.replaceAll(Constants.nonNumericRegExp, '');

    // Limita a 11 dígitos
    final limitedDigits = digitsOnly.length > 11
        ? digitsOnly.substring(0, 11)
        : digitsOnly;

    // Aplica a formatação
    final formatted = _formatCpf(limitedDigits);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  /// Formata uma string de dígitos no padrão XXX.XXX.XXX-XX
  String _formatCpf(String digits) {
    if (digits.isEmpty) return '';

    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if (i == 2 || i == 5) {
        buffer.write('.');
      } else if (i == 8) {
        buffer.write('-');
      }
    }

    return buffer.toString();
  }
}

// InputFormatters para email e outros formatos podem ser adicionados aqui conforme necessário.

/// Formatador de entrada para valores decimais.
class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Permite apenas dígitos e um ponto decimal
    String normalizedText = newValue.text.replaceAll(
      Constants.decimalAllowedRegExp,
      '',
    );

    // Garante que haja no máximo um ponto decimal
    final parts = normalizedText.split('.');
    if (parts.length > 2) {
      normalizedText = '${parts[0]}.${parts.sublist(1).join('')}';
    }

    return TextEditingValue(
      text: normalizedText,
      selection: TextSelection.collapsed(offset: normalizedText.length),
    );
  }
}

/// Formatador de telefone para campos de texto
///
/// Aplica a máscara (XX) XXXXX-XXXX automaticamente enquanto o usuário digita.
/// Remove automaticamente caracteres não-numéricos e limita a 11 dígitos.
class PhoneTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // se oldValue é maior que newValue, significa que o usuário está apagando
    if (oldValue.text.length > newValue.text.length) {
      return newValue;
    }
    // Remove todos os caracteres não-numéricos
    final digitsOnly = newValue.text.replaceAll(Constants.nonNumericRegExp, '');

    // Limita a 11 dígitos
    final limitedDigits = digitsOnly.length > 11
        ? digitsOnly.substring(0, 11)
        : digitsOnly;

    // Aplica a formatação
    final formatted = _formatPhone(limitedDigits);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  /// Formata uma string de dígitos no padrão (XX) XXXXX-XXXX
  String _formatPhone(String digits) {
    if (digits.isEmpty) return '';

    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      if (i == 0) buffer.write('(');
      buffer.write(digits[i]);
      if (i == 1) buffer.write(') ');
      if (i == 6) buffer.write('-');
    }

    return buffer.toString();
  }
}

/// Formatador de CEP para campos de texto
///
/// Aplica a máscara XXXXX-XXX automaticamente enquanto o usuário digita.
/// Remove automaticamente caracteres não-numéricos e limita a 8 dígitos.
class CepTextInputFormatter extends TextInputFormatter {
  /// Posição onde o hífen deve ser inserido no formato CEP
  static const int _cepHyphenPosition = 4;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // se o texto do oldValue é maior que o do newValue, permite que o usuário apague sem reformatar
    if (oldValue.text.length > newValue.text.length) {
      return newValue;
    }
    // Remove todos os caracteres não-numéricos
    final digitsOnly = newValue.text.replaceAll(Constants.nonNumericRegExp, '');

    // Limita a 8 dígitos
    final limitedDigits = digitsOnly.length > 8
        ? digitsOnly.substring(0, 8)
        : digitsOnly;

    // Aplica a formatação
    final formatted = _formatCep(limitedDigits);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  /// Formata uma string de dígitos no padrão XXXXX-XXX
  String _formatCep(String digits) {
    if (digits.isEmpty) return '';

    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if (i == _cepHyphenPosition) {
        buffer.write('-');
      }
    }

    return buffer.toString();
  }
}
