import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/screens/utils/validators.dart';

/// Testes para os validadores de campos.
///
/// Valida que os validadores rejeitam valores inválidos e aceitam valores válidos,
/// com mensagens de erro apropriadas.
void main() {
  group('validatePrice', () {
    test('deve retornar null para preço válido com ponto', () {
      expect(validatePrice('10.50'), isNull);
      expect(validatePrice('100.00'), isNull);
      expect(validatePrice('0.01'), isNull);
    });

    test('deve retornar null para preço válido com vírgula', () {
      expect(validatePrice('10,50'), isNull);
      expect(validatePrice('100,00'), isNull);
      expect(validatePrice('0,01'), isNull);
    });

    test('deve retornar null para preço zero', () {
      expect(validatePrice('0'), isNull);
      expect(validatePrice('0.00'), isNull);
    });

    test('deve retornar null para preço sem decimais', () {
      expect(validatePrice('10'), isNull);
      expect(validatePrice('100'), isNull);
    });

    test('deve retornar erro para valor vazio', () {
      expect(validatePrice(''), isNotNull);
      expect(validatePrice(null), isNotNull);
      expect(validatePrice('   '), isNotNull);
    });

    test('deve retornar erro para valor não numérico', () {
      expect(validatePrice('abc'), isNotNull);
      expect(validatePrice('10.5a'), isNotNull);
      expect(validatePrice('R\$ 10.50'), isNotNull);
    });

    test('deve retornar erro para valor negativo', () {
      final error = validatePrice('-10.50');
      expect(error, isNotNull);
      expect(error, contains('negativo'));
    });

    test('deve retornar erro para mais de 2 casas decimais', () {
      final error = validatePrice('10.505');
      expect(error, isNotNull);
      expect(error, contains('2 casas decimais'));
    });
  });

  group('validateQuantity', () {
    test('deve retornar null para quantidade válida', () {
      expect(validateQuantity('0'), isNull);
      expect(validateQuantity('1'), isNull);
      expect(validateQuantity('100'), isNull);
      expect(validateQuantity('9999'), isNull);
    });

    test('deve retornar erro para valor vazio', () {
      expect(validateQuantity(''), isNotNull);
      expect(validateQuantity(null), isNotNull);
      expect(validateQuantity('   '), isNotNull);
    });

    test('deve retornar erro para valor não numérico', () {
      expect(validateQuantity('abc'), isNotNull);
      expect(validateQuantity('10a'), isNotNull);
    });

    test('deve retornar erro para valor decimal', () {
      final error = validateQuantity('10.5');
      expect(error, isNotNull);
      expect(error, contains('números inteiros'));
    });

    test('deve retornar erro para valor negativo', () {
      final error = validateQuantity('-10');
      expect(error, isNotNull);
      expect(error, contains('negativa'));
    });
  });

  group('validateStock', () {
    test('deve retornar null para estoque válido', () {
      expect(validateStock('0'), isNull);
      expect(validateStock('1'), isNull);
      expect(validateStock('100'), isNull);
      expect(validateStock('9999'), isNull);
    });

    test('deve retornar erro para valor vazio', () {
      expect(validateStock(''), isNotNull);
      expect(validateStock(null), isNotNull);
      expect(validateStock('   '), isNotNull);
    });

    test('deve retornar erro para valor não numérico', () {
      expect(validateStock('abc'), isNotNull);
      expect(validateStock('10a'), isNotNull);
    });

    test('deve retornar erro para valor decimal', () {
      final error = validateStock('10.5');
      expect(error, isNotNull);
      expect(error, contains('números inteiros'));
    });

    test('deve retornar erro para valor negativo', () {
      final error = validateStock('-10');
      expect(error, isNotNull);
      expect(error, contains('negativo'));
    });
  });

  group('validateProductCode', () {
    test('deve retornar null para código válido', () {
      expect(validateProductCode('ABC'), isNull);
      expect(validateProductCode('ABC-123'), isNull);
      expect(validateProductCode('PROD-001'), isNull);
      expect(validateProductCode('12345'), isNull);
      expect(validateProductCode('A1B2C3'), isNull);
    });

    test('deve retornar erro para valor vazio', () {
      expect(validateProductCode(''), isNotNull);
      expect(validateProductCode(null), isNotNull);
      expect(validateProductCode('   '), isNotNull);
    });

    test('deve retornar erro para código muito curto', () {
      final error = validateProductCode('AB');
      expect(error, isNotNull);
      expect(error, contains('mínimo 3'));
    });

    test('deve retornar erro para código muito longo', () {
      final error = validateProductCode('A' * 21);
      expect(error, isNotNull);
      expect(error, contains('máximo 20'));
    });

    test('deve retornar erro para caracteres especiais inválidos', () {
      expect(validateProductCode('ABC@123'), isNotNull);
      expect(validateProductCode('ABC 123'), isNotNull);
      expect(validateProductCode('ABC_123'), isNotNull);
      expect(validateProductCode('ABC.123'), isNotNull);
    });

    test('deve aceitar hífens', () {
      expect(validateProductCode('ABC-123'), isNull);
      expect(validateProductCode('PROD-001-X'), isNull);
    });
  });

  group('validateRequired', () {
    test('deve retornar null para valor válido', () {
      expect(validateRequired('algum texto', 'Campo'), isNull);
      expect(validateRequired('a', 'Campo'), isNull);
    });

    test('deve retornar erro para valor vazio', () {
      final error = validateRequired('', 'Nome');
      expect(error, isNotNull);
      expect(error, contains('Nome'));
      expect(error, contains('obrigatório'));
    });

    test('deve retornar erro para valor null', () {
      final error = validateRequired(null, 'Email');
      expect(error, isNotNull);
      expect(error, contains('Email'));
    });

    test('deve retornar erro para valor apenas com espaços', () {
      final error = validateRequired('   ', 'Endereço');
      expect(error, isNotNull);
      expect(error, contains('Endereço'));
    });
  });

  group('validateMinLength', () {
    test('deve retornar null para comprimento válido', () {
      expect(validateMinLength('abc', 3, 'Nome'), isNull);
      expect(validateMinLength('abcd', 3, 'Nome'), isNull);
      expect(validateMinLength('12345', 5, 'Código'), isNull);
    });

    test('deve retornar erro para comprimento insuficiente', () {
      final error = validateMinLength('ab', 3, 'Nome');
      expect(error, isNotNull);
      expect(error, contains('Nome'));
      expect(error, contains('mínimo 3'));
    });

    test('deve retornar erro para valor vazio', () {
      final error = validateMinLength('', 3, 'Campo');
      expect(error, isNotNull);
      expect(error, contains('obrigatório'));
    });
  });

  group('combineValidators', () {
    test('deve retornar null quando todos os validadores passam', () {
      final validator = combineValidators([
        (value) => validateRequired(value, 'Nome'),
        (value) => validateMinLength(value, 3, 'Nome'),
      ]);

      expect(validator('João'), isNull);
      expect(validator('Maria Silva'), isNull);
    });

    test('deve retornar primeiro erro encontrado', () {
      final validator = combineValidators([
        (value) => validateRequired(value, 'Nome'),
        (value) => validateMinLength(value, 3, 'Nome'),
      ]);

      final error = validator('');
      expect(error, isNotNull);
      expect(error, contains('obrigatório'));
    });

    test('deve retornar erro do segundo validador', () {
      final validator = combineValidators([
        (value) => validateRequired(value, 'Nome'),
        (value) => validateMinLength(value, 5, 'Nome'),
      ]);

      final error = validator('João');
      expect(error, isNotNull);
      expect(error, contains('mínimo 5'));
    });

    test('deve funcionar com validadores customizados', () {
      final validator = combineValidators([
        (value) => validateRequired(value, 'Email'),
        (value) {
          if (value != null && !value.contains('@')) {
            return 'Email inválido';
          }
          return null;
        },
      ]);

      expect(validator(''), isNotNull);
      expect(validator('invalido'), contains('Email inválido'));
      expect(validator('teste@email.com'), isNull);
    });
  });
}
