import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/services/code_generator_service.dart';
import 'package:system_loja/data/database/app_database.dart';

void main() {
  late AppDatabase database;
  late CodeGeneratorService codeGeneratorService;

  setUp(() {
    // Cria um banco de dados em memória para testes
    database = AppDatabase();
    codeGeneratorService = CodeGeneratorService(
      productDao: database.productDao,
      invoiceDao: database.invoiceDao,
    );
  });

  tearDown(() async {
    await database.close();
  });

  group('CodeGeneratorService - Product Code Generation', () {
    test(
      'generateProductCode deve gerar código único no formato PRD-YYYYMMDD-NNNN',
      () async {
        final code = await codeGeneratorService.generateProductCode();

        expect(code, isNotNull);
        expect(code, startsWith('PRD-'));
        expect(
          code.length,
          greaterThanOrEqualTo(17),
        ); // PRD-20260123-0001 = 17 chars

        // Verifica formato com regex
        final regex = RegExp(r'^PRD-\d{8}-\d{4}$');
        expect(
          regex.hasMatch(code),
          isTrue,
          reason: 'Código deve seguir formato PRD-YYYYMMDD-NNNN',
        );
      },
    );

    test(
      'generateProductCode deve gerar códigos diferentes em sequência',
      () async {
        final code1 = await codeGeneratorService.generateProductCode();

        // Insere o primeiro produto para ocupar o código
        final product1 = Product(
          name: 'Produto Teste 1',
          description: 'Descrição teste 1',
          price: 10.0,
          stockQuantity: 5,
          categoryId: 1,
          code: code1,
        );
        await database.productDao.insertProduct(product1);

        final code2 = await codeGeneratorService.generateProductCode();

        expect(code1, isNot(equals(code2)));
        expect(code2, startsWith('PRD-'));
      },
    );

    test(
      'checkProductCodeExists deve retornar false para código inexistente',
      () async {
        final exists = await codeGeneratorService.checkProductCodeExists(
          'CODIGO_NAO_EXISTE',
        );

        expect(exists, isFalse);
      },
    );

    test(
      'checkProductCodeExists deve retornar true para código existente',
      () async {
        final code = 'PRD-TEST-0001';
        final product = Product(
          name: 'Produto Teste',
          description: 'Descrição teste',
          price: 10.0,
          stockQuantity: 5,
          categoryId: 1,
          code: code,
        );
        await database.productDao.insertProduct(product);

        final exists = await codeGeneratorService.checkProductCodeExists(code);

        expect(exists, isTrue);
      },
    );
  });

  group('CodeGeneratorService - Product Code Validation', () {
    test('validateProductCode deve rejeitar código vazio', () async {
      final result = await codeGeneratorService.validateProductCode('');

      expect(result.isValid, isFalse);
      expect(result.message, contains('vazio'));
    });

    test(
      'validateProductCode deve rejeitar código com menos de 3 caracteres',
      () async {
        final result = await codeGeneratorService.validateProductCode('AB');

        expect(result.isValid, isFalse);
        expect(result.message, contains('mínimo 3'));
      },
    );

    test(
      'validateProductCode deve rejeitar código com mais de 50 caracteres',
      () async {
        final longCode = 'A' * 51;
        final result = await codeGeneratorService.validateProductCode(longCode);

        expect(result.isValid, isFalse);
        expect(result.message, contains('máximo 50'));
      },
    );

    test('validateProductCode deve rejeitar código já existente', () async {
      final code = 'PRD-EXISTING-0001';
      final product = Product(
        name: 'Produto Existente',
        description: 'Descrição',
        price: 10.0,
        stockQuantity: 5,
        categoryId: 1,
        code: code,
      );
      await database.productDao.insertProduct(product);

      final result = await codeGeneratorService.validateProductCode(code);

      expect(result.isValid, isFalse);
      expect(result.message, contains('já existe'));
    });

    test('validateProductCode deve aceitar código válido e único', () async {
      final result = await codeGeneratorService.validateProductCode(
        'PRD-VALID-0001',
      );

      expect(result.isValid, isTrue);
      expect(result.message, contains('válido'));
    });
  });

  group('CodeGeneratorService - Invoice Number Generation', () {
    test(
      'generateInvoiceNumber deve gerar número único no formato NF-YYYYMMDD-NNNN',
      () async {
        final invoiceNumber = await codeGeneratorService
            .generateInvoiceNumber();

        expect(invoiceNumber, isNotNull);
        expect(invoiceNumber, startsWith('NF-'));
        expect(
          invoiceNumber.length,
          greaterThanOrEqualTo(16),
        ); // NF-20260123-0001 = 16 chars

        // Verifica formato com regex
        final regex = RegExp(r'^NF-\d{8}-\d{4}$');
        expect(
          regex.hasMatch(invoiceNumber),
          isTrue,
          reason: 'Número deve seguir formato NF-YYYYMMDD-NNNN',
        );
      },
    );

    test(
      'generateInvoiceNumber deve gerar números diferentes em sequência',
      () async {
        final invoiceNumber1 = await codeGeneratorService
            .generateInvoiceNumber();

        // Insere a primeira nota fiscal para ocupar o número
        final invoice1 = Invoice(
          data: InvoiceData(
            invoiceNumber: invoiceNumber1,
            customerId: 1,
            customerName: 'Cliente Teste',
            customerCpf: '12345678900',
            items: [
              InvoiceItem(
                productId: kInvalidId,
                productCode: 'PRD-001',
                productName: 'Produto 1',
                quantity: 1,
                unitPrice: 10.0,
              ),
            ],
            paymentMethod: 'Dinheiro',
          ),
        );
        await database.invoiceDao.insertInvoiceWithItems(invoice1);

        final invoiceNumber2 = await codeGeneratorService
            .generateInvoiceNumber();

        expect(invoiceNumber1, isNot(equals(invoiceNumber2)));
        expect(invoiceNumber2, startsWith('NF-'));
      },
    );

    test(
      'checkInvoiceNumberExists deve retornar false para número inexistente',
      () async {
        final exists = await codeGeneratorService.checkInvoiceNumberExists(
          'NF-NAO-EXISTE',
        );

        expect(exists, isFalse);
      },
    );

    test(
      'checkInvoiceNumberExists deve retornar true para número existente',
      () async {
        final invoiceNumber = 'NF-TEST-0001';
        final invoice = Invoice(
          data: InvoiceData(
            invoiceNumber: invoiceNumber,
            customerId: 1,
            customerName: 'Cliente Teste',
            customerCpf: '12345678900',
            items: [
              InvoiceItem(
                productId: kInvalidId,
                productCode: 'PRD-001',
                productName: 'Produto 1',
                quantity: 1,
                unitPrice: 10.0,
              ),
            ],
            paymentMethod: 'Dinheiro',
          ),
        );
        await database.invoiceDao.insertInvoiceWithItems(invoice);

        final exists = await codeGeneratorService.checkInvoiceNumberExists(
          invoiceNumber,
        );

        expect(exists, isTrue);
      },
    );
  });

  group('CodeGeneratorService - Invoice Number Validation', () {
    test('validateInvoiceNumber deve rejeitar número vazio', () async {
      final result = await codeGeneratorService.validateInvoiceNumber('');

      expect(result.isValid, isFalse);
      expect(result.message, contains('vazio'));
    });

    test(
      'validateInvoiceNumber deve rejeitar número com menos de 3 caracteres',
      () async {
        final result = await codeGeneratorService.validateInvoiceNumber('AB');

        expect(result.isValid, isFalse);
        expect(result.message, contains('mínimo 3'));
      },
    );

    test(
      'validateInvoiceNumber deve rejeitar número com mais de 50 caracteres',
      () async {
        final longNumber = 'A' * 51;
        final result = await codeGeneratorService.validateInvoiceNumber(
          longNumber,
        );

        expect(result.isValid, isFalse);
        expect(result.message, contains('máximo 50'));
      },
    );

    test('validateInvoiceNumber deve rejeitar número já existente', () async {
      final invoiceNumber = 'NF-EXISTING-0001';
      final invoice = Invoice(
        data: InvoiceData(
          invoiceNumber: invoiceNumber,
          customerId: 1,
          customerName: 'Cliente Existente',
          customerCpf: '12345678900',
          items: [
            InvoiceItem(
              productId: kInvalidId,
              productCode: 'PRD-001',
              productName: 'Produto 1',
              quantity: 1,
              unitPrice: 10.0,
            ),
          ],
          paymentMethod: 'Dinheiro',
        ),
      );
      await database.invoiceDao.insertInvoiceWithItems(invoice);

      final result = await codeGeneratorService.validateInvoiceNumber(
        invoiceNumber,
      );

      expect(result.isValid, isFalse);
      expect(result.message, contains('já existe'));
    });

    test('validateInvoiceNumber deve aceitar número válido e único', () async {
      final result = await codeGeneratorService.validateInvoiceNumber(
        'NF-VALID-0001',
      );

      expect(result.isValid, isTrue);
      expect(result.message, contains('válido'));
    });
  });
}
