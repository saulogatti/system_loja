import 'package:flutter/services.dart';
import 'package:system_loja/core/constants/app_constants.dart';

String formatarParaReal(String valorString) {
  // Limpa a sujeira que o usuário digitar (remove tudo que não for dígito)
  final apenasNumeros = valorString.replaceAll(RegExp(r'[^\d]'), '');

  if (apenasNumeros.isEmpty) return '0,00';

  // Converte para double (considerando os últimos 2 dígitos como centavos)
  final valorDouble = double.parse(apenasNumeros) / 100;

  // O "pulo do gato" para localizar em PT-BR
  return valorDouble.toStringAsFixed(2);
}

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
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length > newValue.text.length || newValue.text.isEmpty) {
      //Se o usuário está apagando e o campo está vazio, retorna vazio
      return TextEditingValue(text: '', selection: TextSelection.collapsed(offset: 0));
    }
    if (oldValue.text.length < newValue.text.length && newValue.text.contains(',')) {
      //Se o usuário está digitando uma vírgula, remove a vírgula e adiciona um ponto
      return TextEditingValue(
        text: newValue.text.replaceAll(',', '.'),
        selection: TextSelection.collapsed(offset: newValue.text.length),
      );
    } else if (oldValue.text.length < newValue.text.length && !newValue.text.contains('.')) {
      //Se o usuário está digitando um ponto, remove o ponto e adiciona uma vírgula
      return TextEditingValue(
        text: newValue.text,
        selection: TextSelection.collapsed(offset: newValue.text.length),
      );
    }
    final text = newValue.text.replaceAll(Constants.priceAllowedRegExp, '');
    // Se o valor contém um ponto, limita a 2 casas decimais e remove o ponto extra

    return TextEditingValue(
      text: formatarParaReal(text),
      selection: TextSelection.collapsed(offset: formatarParaReal(text).length),
    );
  }
}

class ProductCodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Permite apenas letras, números e hífens
    final text = newValue.text.replaceAll(Constants.productCodeReplaceRegExp, '').toUpperCase();

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
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
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Permite apenas dígitos
    final text = newValue.text.replaceAll(Constants.nonNumericRegExp, '');

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
