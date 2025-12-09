import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/utils/input_formatters.dart';

/// Testes para os formatadores de entrada.
///
/// Valida que os formatadores aplicam as regras corretas de formatação
/// e filtram caracteres inválidos.
void main() {
  group('PriceInputFormatter', () {
    late PriceInputFormatter formatter;

    setUp(() {
      formatter = PriceInputFormatter();
    });

    TextEditingValue format(String text) {
      return formatter.formatEditUpdate(
        const TextEditingValue(),
        TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        ),
      );
    }

    test('deve aceitar números inteiros', () {
      final result = format('10');
      expect(result.text, equals('10'));
    });

    test('deve aceitar números decimais com ponto', () {
      final result = format('10.50');
      expect(result.text, equals('10.50'));
    });

    test('deve converter vírgula para ponto', () {
      final result = format('10,50');
      expect(result.text, equals('10.50'));
    });

    test('deve limitar a 2 casas decimais', () {
      final result = format('10.505');
      expect(result.text, equals('10.50'));
    });

    test('deve permitir apenas um ponto decimal', () {
      final result = format('10.5.5');
      expect(result.text, equals('10.55'));
    });

    test('deve remover caracteres não numéricos', () {
      final result = format('R\$ 10.50');
      expect(result.text, equals('10.50'));
    });

    test('deve aceitar zero', () {
      final result = format('0');
      expect(result.text, equals('0'));
    });

    test('deve aceitar zero com decimais', () {
      final result = format('0.99');
      expect(result.text, equals('0.99'));
    });

    test('deve retornar vazio para entrada vazia', () {
      final result = format('');
      expect(result.text, equals(''));
    });

    test('deve manter cursor no final', () {
      final result = format('10.50');
      expect(result.selection.baseOffset, equals(5));
    });
  });

  group('QuantityInputFormatter', () {
    late QuantityInputFormatter formatter;

    setUp(() {
      formatter = QuantityInputFormatter();
    });

    TextEditingValue format(String text) {
      return formatter.formatEditUpdate(
        const TextEditingValue(),
        TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        ),
      );
    }

    test('deve aceitar números inteiros', () {
      final result = format('10');
      expect(result.text, equals('10'));
    });

    test('deve aceitar zero', () {
      final result = format('0');
      expect(result.text, equals('0'));
    });

    test('deve aceitar números grandes', () {
      final result = format('9999');
      expect(result.text, equals('9999'));
    });

    test('deve remover pontos decimais', () {
      final result = format('10.5');
      expect(result.text, equals('105'));
    });

    test('deve remover vírgulas', () {
      final result = format('10,5');
      expect(result.text, equals('105'));
    });

    test('deve remover letras', () {
      final result = format('10a5');
      expect(result.text, equals('105'));
    });

    test('deve remover caracteres especiais', () {
      final result = format('10@5#3');
      expect(result.text, equals('1053'));
    });

    test('deve retornar vazio para entrada vazia', () {
      final result = format('');
      expect(result.text, equals(''));
    });

    test('deve manter cursor no final', () {
      final result = format('123');
      expect(result.selection.baseOffset, equals(3));
    });
  });

  group('ProductCodeInputFormatter', () {
    late ProductCodeInputFormatter formatter;

    setUp(() {
      formatter = ProductCodeInputFormatter();
    });

    TextEditingValue format(String text) {
      return formatter.formatEditUpdate(
        const TextEditingValue(),
        TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        ),
      );
    }

    test('deve aceitar letras e números', () {
      final result = format('ABC123');
      expect(result.text, equals('ABC123'));
    });

    test('deve aceitar hífens', () {
      final result = format('ABC-123');
      expect(result.text, equals('ABC-123'));
    });

    test('deve converter para maiúsculas', () {
      final result = format('abc123');
      expect(result.text, equals('ABC123'));
    });

    test('deve converter letras minúsculas com hífens', () {
      final result = format('abc-123');
      expect(result.text, equals('ABC-123'));
    });

    test('deve remover espaços', () {
      final result = format('ABC 123');
      expect(result.text, equals('ABC123'));
    });

    test('deve remover underscores', () {
      final result = format('ABC_123');
      expect(result.text, equals('ABC123'));
    });

    test('deve remover pontos', () {
      final result = format('ABC.123');
      expect(result.text, equals('ABC123'));
    });

    test('deve remover caracteres especiais', () {
      final result = format('ABC@123#XYZ');
      expect(result.text, equals('ABC123XYZ'));
    });

    test('deve aceitar apenas números', () {
      final result = format('12345');
      expect(result.text, equals('12345'));
    });

    test('deve aceitar apenas letras', () {
      final result = format('ABCDE');
      expect(result.text, equals('ABCDE'));
    });

    test('deve retornar vazio para entrada vazia', () {
      final result = format('');
      expect(result.text, equals(''));
    });

    test('deve manter cursor no final', () {
      final result = format('ABC-123');
      expect(result.selection.baseOffset, equals(7));
    });

    test('deve processar entrada mista corretamente', () {
      final result = format('prod-001');
      expect(result.text, equals('PROD-001'));
    });
  });
}
