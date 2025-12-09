import 'package:flutter/services.dart';

/// Formatador de entrada para campos de preço.
///
/// Permite apenas números e um separador decimal (ponto ou vírgula).
/// Limita a duas casas decimais.
///
/// Exemplo:
/// ```dart
/// TextFormField(
///   inputFormatters: [PriceInputFormatter()],
///   keyboardType: TextInputType.numberWithOptions(decimal: true),
/// )
/// ```
class PriceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Permite apenas números, vírgula e ponto
    final text = newValue.text.replaceAll(RegExp(r'[^0-9,.]'), '');
    
    // Se estiver vazio, retorna vazio
    if (text.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }
    
    // Substitui vírgula por ponto
    String normalizedText = text.replaceAll(',', '.');
    
    // Permite apenas um ponto decimal
    final parts = normalizedText.split('.');
    // Permite apenas um ponto decimal
    if (normalizedText.indexOf('.') != normalizedText.lastIndexOf('.')) {
      normalizedText = normalizedText.substring(0, normalizedText.lastIndexOf('.'));
    }
    
    // Limita a 2 casas decimais
    final decimalParts = normalizedText.split('.');
    if (decimalParts.length > 1) {
      final integerPart = decimalParts[0];
      final decimalPart = decimalParts[1].length > 2
          ? decimalParts[1].substring(0, 2)
          : decimalParts[1];
      normalizedText = '$integerPart.$decimalPart';
    }
    
    return TextEditingValue(
      text: normalizedText,
      selection: TextSelection.collapsed(offset: normalizedText.length),
    );
  }
}

/// Formatador de entrada para campos de quantidade/estoque.
///
/// Permite apenas números inteiros (sem decimais).
///
/// Exemplo:
/// ```dart
/// TextFormField(
///   inputFormatters: [QuantityInputFormatter()],
///   keyboardType: TextInputType.number,
/// )
/// ```
class QuantityInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Permite apenas dígitos
    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

/// Formatador de entrada para códigos de produto.
///
/// Permite apenas letras, números e hífens.
/// Converte para maiúsculas automaticamente.
///
/// Exemplo:
/// ```dart
/// TextFormField(
///   inputFormatters: [ProductCodeInputFormatter()],
/// )
/// ```
class ProductCodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Permite apenas letras, números e hífens
    final text = newValue.text
        .replaceAll(RegExp(r'[^a-zA-Z0-9\-]'), '')
        .toUpperCase();
    
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
