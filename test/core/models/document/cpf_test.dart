import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/exceptions/validation_exception.dart';
import 'package:system_loja/core/models/document/cpf.dart';

void main() {
  group('Cpf', () {
    test('should create a valid formatted CPF', () {
      const value = '529.982.247-25';
      final cpf = Cpf(value);
      expect(cpf.value, value);
      expect(cpf.formatted, value);
    });

    test('should create a valid unformatted CPF', () {
      const value = '52998224725';
      final cpf = Cpf(value);
      expect(cpf.value, value);
      expect(cpf.formatted, '529.982.247-25');
    });

    test('should allow defaultObject special case', () {
      final cpf = Cpf.defaultObject();
      expect(cpf.value, '123.456.789-09');
    });

    test('should throw ValidationException for invalid format', () {
      expect(() => Cpf('123.456.789-0'), throwsA(isA<ValidationException>()));
      expect(() => Cpf('1234567890'), throwsA(isA<ValidationException>()));
      expect(() => Cpf('abc'), throwsA(isA<ValidationException>()));
    });

    test('should throw ValidationException for invalid check digits', () {
      expect(() => Cpf('529.982.247-26'), throwsA(isA<ValidationException>()));
      expect(() => Cpf('52998224724'), throwsA(isA<ValidationException>()));
    });

    test('should throw ValidationException for repeated digits', () {
      expect(() => Cpf('111.111.111-11'), throwsA(isA<ValidationException>()));
      expect(() => Cpf('11111111111'), throwsA(isA<ValidationException>()));
    });

    test('validateDocument should return null for valid CPF', () {
      final cpf = Cpf('529.982.247-25');
      expect(cpf.validateDocument(), isNull);
    });
  });
}
