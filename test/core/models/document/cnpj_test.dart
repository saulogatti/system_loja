import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/exceptions/validation_exception.dart';
import 'package:system_loja/core/models/document/cnpj.dart';

void main() {
  group('Cnpj', () {
    test('should create a valid formatted CNPJ', () {
      const value = '00.000.000/0001-91';
      final cnpj = Cnpj(value);
      expect(cnpj.value, value);
      expect(cnpj.formatted, value);
    });

    test('should create a valid unformatted CNPJ', () {
      const value = '00000000000191';
      final cnpj = Cnpj(value);
      expect(cnpj.value, value);
      expect(cnpj.formatted, '00.000.000/0001-91');
    });

    test('should throw ValidationException for invalid format', () {
      expect(() => Cnpj('00.000.000/0001-911'), throwsA(isA<ValidationException>()));
      expect(() => Cnpj('0000000000019'), throwsA(isA<ValidationException>()));
      expect(() => Cnpj('abc'), throwsA(isA<ValidationException>()));
    });

    test('should throw ValidationException for invalid check digits', () {
      expect(() => Cnpj('00.000.000/0001-92'), throwsA(isA<ValidationException>()));
      expect(() => Cnpj('00000000000190'), throwsA(isA<ValidationException>()));
    });

    test('should throw ValidationException for repeated digits', () {
      expect(() => Cnpj('11.111.111/1111-11'), throwsA(isA<ValidationException>()));
      expect(() => Cnpj('11111111111111'), throwsA(isA<ValidationException>()));
    });

    test('validateDocument should return null for valid CNPJ', () {
      final cnpj = Cnpj('00.000.000/0001-91');
      expect(cnpj.validateDocument(), isNull);
    });
  });
}
