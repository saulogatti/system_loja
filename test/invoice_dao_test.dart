import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/dao/product_dao.dart';

import 'support/invoice_transaction_test_support.dart';
import 'support/test_app_database.dart';

/// Testes para o InvoiceDao.
///
/// Verifica se o estoque dos produtos é atualizado corretamente ao salvar notas
/// fiscais de entrada e de saída.
void main() {
  late AppDatabase database;
  late ProductDao productDao;

  setUp(() {
    database = AppDatabase(
      applicationSupportDirectory: testApplicationSupportDirectory,
      tempDirectoryPath: testSqliteTempDirectoryPath,
    );
    productDao = database.productDao;
  });

  tearDown(() async {
    await database.close();
  });

  Future<int> insertProduct({int stockQuantity = 10}) {
    return productDao.insertProduct(
      Product(
        name: 'Produto Teste',
        description: 'Descrição teste',
        price: 5.0,
        stockQuantity: stockQuantity,
        code: 'PROD-${DateTime.now().microsecondsSinceEpoch}',
      ),
    );
  }

  Invoice buildInvoice({
    required int productId,
    required int quantity,
    required InvoiceType type,
  }) {
    return Invoice(
      data: InvoiceData(
        invoiceNumber: 'NF-${DateTime.now().microsecondsSinceEpoch}',
        companyId: type == InvoiceType.entry ? 1 : null,
        companyName: type == InvoiceType.entry ? 'Fornecedor Teste' : null,
        companyCnpj: type == InvoiceType.entry ? '00.000.000/0001-00' : null,
        customerId: type == InvoiceType.exit ? 1 : null,
        customerName: type == InvoiceType.exit ? 'Cliente Teste' : null,
        customerCpf: type == InvoiceType.exit ? '000.000.000-00' : null,
        type: type,
        items: [
          InvoiceItem(
            productId: productId,
            productName: 'Produto Teste',
            productCode: 'PROD-001',
            quantity: quantity,
            unitPrice: 5.0,
          ),
        ],
        paymentMethod: 'Dinheiro',
      ),
    );
  }

  group('Orquestração nota + itens + estoque (espelho do SalesRepository)', () {
    group('nota de entrada', () {
      test('deve somar a quantidade do item ao estoque do produto', () async {
        // Arrange
        const initialStock = 10;
        const invoiceQuantity = 1;
        final productId = await insertProduct(stockQuantity: initialStock);

        final invoice = buildInvoice(
          productId: productId,
          quantity: invoiceQuantity,
          type: InvoiceType.entry,
        );

        // Act
        await insertInvoiceWithItemsLikeRepository(database, invoice);

        // Assert
        final product = await productDao.getById(productId);
        expect(
          product!.stockQuantity,
          equals(initialStock + invoiceQuantity),
          reason:
              'Nota de entrada deve somar a quantidade ao estoque do produto',
        );
      });

      test('deve somar múltiplas quantidades ao estoque', () async {
        // Arrange
        const initialStock = 5;
        const invoiceQuantity = 7;
        final productId = await insertProduct(stockQuantity: initialStock);

        final invoice = buildInvoice(
          productId: productId,
          quantity: invoiceQuantity,
          type: InvoiceType.entry,
        );

        // Act
        await insertInvoiceWithItemsLikeRepository(database, invoice);

        // Assert
        final product = await productDao.getById(productId);
        expect(product!.stockQuantity, equals(initialStock + invoiceQuantity));
      });
    });

    group('nota de saída', () {
      test('deve subtrair a quantidade do item do estoque do produto', () async {
        // Arrange
        const initialStock = 10;
        const invoiceQuantity = 3;
        final productId = await insertProduct(stockQuantity: initialStock);

        final invoice = buildInvoice(
          productId: productId,
          quantity: invoiceQuantity,
          type: InvoiceType.exit,
        );

        // Act
        await insertInvoiceWithItemsLikeRepository(database, invoice);

        // Assert
        final product = await productDao.getById(productId);
        expect(
          product!.stockQuantity,
          equals(initialStock - invoiceQuantity),
          reason:
              'Nota de saída deve subtrair a quantidade do estoque do produto',
        );
      });

      test(
        'deve falhar antes de persistir quando estoque insuficiente (nota de saída)',
        () async {
          const initialStock = 2;
          const invoiceQuantity = 5;
          final productId = await insertProduct(stockQuantity: initialStock);

          final invoice = buildInvoice(
            productId: productId,
            quantity: invoiceQuantity,
            type: InvoiceType.exit,
          );

          expect(
            () => insertInvoiceWithItemsLikeRepository(database, invoice),
            throwsStateError,
          );
          final product = await productDao.getById(productId);
          expect(product!.stockQuantity, equals(initialStock));
        },
      );
    });
  });
}
