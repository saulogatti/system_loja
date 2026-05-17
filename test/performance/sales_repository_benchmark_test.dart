import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/domain/repository/sales_repository.dart';
import 'package:system_loja/domain/code_generator_service.dart';

import '../support/test_app_database.dart';

void main() {
  late AppDatabase database;
  late SalesRepository salesRepository;

  setUp(() {
    database = AppDatabase(
      applicationSupportDirectory: testApplicationSupportDirectory,
      tempDirectoryPath: testSqliteTempDirectoryPath,
    );
    final codeGeneratorService = CodeGeneratorService(
      productDao: database.productDao,
      invoiceDao: database.invoiceDao,
    );
    salesRepository = SalesRepository(
      invoiceDao: database.invoiceDao,
      invoiceItemDao: database.invoiceItemDao,
      productDao: database.productDao,
      codeGeneratorService: codeGeneratorService,
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('Benchmark: saveSale with many items (baseline)', () async {
    const itemCount = 50;
    final productIds = <int>[];

    // Create products
    for (int i = 0; i < itemCount; i++) {
      final id = await database.productDao.insertProduct(
        Product(
          name: 'Product $i',
          description: 'Description $i',
          price: 10.0,
          stockQuantity: 100,
          code: 'PROD-$i',
        ),
      );
      productIds.add(id);
    }

    final items = <InvoiceItem>[];
    for (int i = 0; i < itemCount; i++) {
      items.add(
        InvoiceItem(
          productId: productIds[i],
          productName: 'Product $i',
          productCode: 'PROD-$i',
          quantity: 1,
          unitPrice: 10.0,
        ),
      );
    }

    final invoice = Invoice(
      data: InvoiceData(
        invoiceNumber: 'NF-BENCHMARK',
        type: InvoiceType.exit,
        items: items,
        paymentMethod: 'Credit Card',
        customerName: 'Test Customer',
      ),
    );

    // Warm up
    await salesRepository.saveSale(invoice.copyWith(
      data: invoice.data.copyWith(invoiceNumber: 'NF-WARMUP'),
    ));

    // Measurement
    final stopwatch = Stopwatch()..start();
    final result = await salesRepository.saveSale(invoice);
    stopwatch.stop();

    expect(result.isSuccess, isTrue);
    print('Benchmark (saveSale with $itemCount items): ${stopwatch.elapsedMilliseconds}ms');
  });
}
