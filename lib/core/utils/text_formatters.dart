import 'package:flutter/services.dart';

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
    final regExp = RegExp(r'[^0-9]');
    final digitsOnly = newValue.text.replaceAll(regExp, '');

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
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

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
    final regExp = RegExp(r'[^0-9]');
    final digitsOnly = newValue.text.replaceAll(regExp, '');

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

// InputFormatters para email e outros formatos podem ser adicionados aqui conforme necessário.
// TODO: Adicionar input formatter para email se necessário.