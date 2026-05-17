import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/exceptions/product_exception.dart';

/// Testes para a classe ProductException.
///
/// Verifica se as mensagens de erro são claras e bem formatadas,
/// especialmente a mensagem de estoque insuficiente que deve
/// especificar claramente o estoque disponível e a quantidade solicitada.
void main() {
  group('ProductException', () {
    group('insufficientStock', () {
      test(
        'deve criar exceção com mensagem clara sobre estoque disponível e quantidade solicitada',
        () {
          // Arrange
          const code = 'PROD-001';
          const available = 5;
          const requested = 10;

          // Act
          final exception = ProductException.insufficientStock(
            code,
            available,
            requested,
          );

          // Assert
          expect(exception.type, ProductErrorType.insufficientStock);
          expect(exception.message, 'Estoque insuficiente');
          expect(exception.productCode, code);
          expect(
            exception.details,
            'Estoque disponível: $available. Quantidade solicitada: $requested.',
          );
        },
      );

      test('deve incluir labels claros na mensagem de detalhes', () {
        // Arrange
        const code = 'PROD-123';
        const available = 0;
        const requested = 1;

        // Act
        final exception = ProductException.insufficientStock(
          code,
          available,
          requested,
        );

        // Assert
        expect(exception.details, contains('Estoque disponível:'));
        expect(exception.details, contains('Quantidade solicitada:'));
        expect(exception.details, contains('$available'));
        expect(exception.details, contains('$requested'));
      });

      test('deve formatar corretamente a mensagem toString()', () {
        // Arrange
        const code = 'PROD-456';
        const available = 3;
        const requested = 7;

        // Act
        final exception = ProductException.insufficientStock(
          code,
          available,
          requested,
        );

        // Assert
        final stringRepresentation = exception.toString();
        expect(stringRepresentation, contains('ProductException'));
        expect(stringRepresentation, contains('insufficientStock'));
        expect(stringRepresentation, contains('Estoque insuficiente'));
        expect(stringRepresentation, contains('código: $code'));
        expect(
          stringRepresentation,
          contains('Estoque disponível: $available'),
        );
        expect(
          stringRepresentation,
          contains('Quantidade solicitada: $requested'),
        );
      });

      test('deve formatar corretamente a mensagem userMessage', () {
        // Arrange
        const code = 'PROD-789';
        const available = 10;
        const requested = 15;

        // Act
        final exception = ProductException.insufficientStock(
          code,
          available,
          requested,
        );

        // Assert
        final userMessage = exception.userMessage;
        expect(userMessage, contains('Estoque insuficiente'));
        expect(userMessage, contains('Estoque disponível: $available'));
        expect(userMessage, contains('Quantidade solicitada: $requested'));
      });

      test('deve funcionar com estoque zero', () {
        // Arrange
        const code = 'PROD-000';
        const available = 0;
        const requested = 100;

        // Act
        final exception = ProductException.insufficientStock(
          code,
          available,
          requested,
        );

        // Assert
        expect(
          exception.details,
          'Estoque disponível: 0. Quantidade solicitada: 100.',
        );
      });

      test('deve funcionar com grandes quantidades', () {
        // Arrange
        const code = 'PROD-999';
        const available = 1000;
        const requested = 5000;

        // Act
        final exception = ProductException.insufficientStock(
          code,
          available,
          requested,
        );

        // Assert
        expect(
          exception.details,
          'Estoque disponível: 1000. Quantidade solicitada: 5000.',
        );
      });
    });

    group('other factory methods', () {
      test('duplicateCode deve criar exceção correta', () {
        // Arrange
        const code = 'PROD-DUP';

        // Act
        final exception = ProductException.duplicateCode(code);

        // Assert
        expect(exception.type, ProductErrorType.duplicateCode);
        expect(exception.message, 'Código de produto já existe');
        expect(exception.productCode, code);
        expect(exception.details, contains(code));
      });

      test('notFound deve criar exceção correta', () {
        // Arrange
        const code = 'PROD-404';

        // Act
        final exception = ProductException.notFound(code);

        // Assert
        expect(exception.type, ProductErrorType.notFound);
        expect(exception.message, 'Produto não encontrado');
        expect(exception.productCode, code);
      });

      test('invalidPrice deve criar exceção correta', () {
        // Arrange
        const code = 'PROD-PRICE';
        const price = -10.50;

        // Act
        final exception = ProductException.invalidPrice(code, price);

        // Assert
        expect(exception.type, ProductErrorType.invalidPrice);
        expect(exception.message, 'Preço inválido');
        expect(exception.productCode, code);
        expect(exception.details, contains('R\$'));
      });

      test('invalidStock deve criar exceção correta', () {
        // Arrange
        const code = 'PROD-STOCK';
        const stock = -5;

        // Act
        final exception = ProductException.invalidStock(code, stock);

        // Assert
        expect(exception.type, ProductErrorType.invalidStock);
        expect(exception.message, 'Estoque inválido');
        expect(exception.productCode, code);
      });
    });
  });
}
