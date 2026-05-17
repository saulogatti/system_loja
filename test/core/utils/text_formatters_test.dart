import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/screens/utils/text_formatters.dart';
 

void main() {
  group('CnpjTextInputFormatter', () {
    final formatter = CnpjTextInputFormatter();

    test('should format empty value correctly', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue.empty;
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '');
    });

    test('should format CNPJ digits sequentially', () {
      var oldValue = TextEditingValue.empty;
      var newValue = const TextEditingValue(text: '1');
      var result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '1');

      oldValue = result;
      newValue = const TextEditingValue(text: '12');
      result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12.');

      oldValue = result;
      newValue = const TextEditingValue(text: '12.3');
      result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12.3');
    });

    test('should apply full CNPJ mask', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '12345678000199');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12.345.678/0001-99');
    });

    test('should limit to 14 digits', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '12345678000199999');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12.345.678/0001-99');
    });

    test('should allow deletion without re-formatting', () {
      const oldValue = TextEditingValue(text: '12.');
      const newValue = TextEditingValue(text: '12');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12');
    });

    test('should remove non-numeric characters', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '12a34');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12.34');
    });
  });

  group('CpfTextInputFormatter', () {
    final formatter = CpfTextInputFormatter();

    test('should format CPF digits sequentially', () {
      var oldValue = TextEditingValue.empty;
      var newValue = const TextEditingValue(text: '123');
      var result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '123.');

      oldValue = result;
      newValue = const TextEditingValue(text: '123.4');
      result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '123.4');
    });

    test('should apply full CPF mask', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '12345678901');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '123.456.789-01');
    });

    test('should limit to 11 digits', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1234567890122');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '123.456.789-01');
    });

    test('should allow deletion without re-formatting', () {
      const oldValue = TextEditingValue(text: '123.');
      const newValue = TextEditingValue(text: '123');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '123');
    });
  });

  group('DecimalInputFormatter', () {
    final formatter = DecimalInputFormatter();

    test('should allow valid decimal numbers', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '12.34');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12.34');
    });

    test('should allow only one decimal point', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '12.34.56');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12.3456');
    });

    test('should remove non-numeric/non-dot characters', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '12a.3b4');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12.34');
    });
  });

  group('PhoneTextInputFormatter', () {
    final formatter = PhoneTextInputFormatter();

    test('should format phone digits sequentially', () {
      var oldValue = TextEditingValue.empty;
      var newValue = const TextEditingValue(text: '1');
      var result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '(1');

      oldValue = result;
      newValue = const TextEditingValue(text: '(12');
      result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '(12) ');

      oldValue = result;
      newValue = const TextEditingValue(text: '(12) 34567');
      result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '(12) 34567-');
    });

    test('should apply full phone mask', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '11912345678');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '(11) 91234-5678');
    });

    test('should limit to 11 digits', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1191234567899');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '(11) 91234-5678');
    });

    test('should allow deletion without re-formatting', () {
      const oldValue = TextEditingValue(text: '(11) ');
      const newValue = TextEditingValue(text: '(11)');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '(11)');
    });
  });

  group('CepTextInputFormatter', () {
    final formatter = CepTextInputFormatter();

    test('should format CEP digits sequentially', () {
      var oldValue = TextEditingValue.empty;
      var newValue = const TextEditingValue(text: '12345');
      var result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12345-');

      oldValue = result;
      newValue = const TextEditingValue(text: '12345-6');
      result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12345-6');
    });

    test('should apply full CEP mask', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '12345678');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12345-678');
    });

    test('should limit to 8 digits', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1234567899');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12345-678');
    });

    test('should allow deletion without re-formatting', () {
      const oldValue = TextEditingValue(text: '12345-');
      const newValue = TextEditingValue(text: '12345');
      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '12345');
    });
  });
}
