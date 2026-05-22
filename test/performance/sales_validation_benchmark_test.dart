import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/dao/product_dao.dart';

import '../support/test_app_database.dart';

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

  Future<List<int>> insertProducts(int count) async {
    final ids = <int>[];
    for (int i = 0; i < count; i++) {
      final id = await productDao.insertProduct(
        Product(
          name: 'Produto $i',
          description: 'Descrição $i',
          price: 10.0,
          stockQuantity: 100,
          code: 'PROD-$i-${DateTime.now().microsecondsSinceEpoch}',
        ),
      );
      ids.add(id);
    }
    return ids;
  }

  Invoice buildInvoice(List<int> productIds, int quantityPerItem) {
    return Invoice(
      data: InvoiceData(
        invoiceNumber: 'NF-BENCH-${DateTime.now().microsecondsSinceEpoch}',
        type: InvoiceType.exit,
        items: productIds.map((id) => InvoiceItem(
          productId: id,
          productName: 'Produto $id',
          productCode: 'PROD-$id',
          quantity: quantityPerItem,
          unitPrice: 10.0,
        )).toList(),
        paymentMethod: 'Dinheiro',
      ),
    );
  }

  test('Benchmark N+1 Query vs Batch Fetching', () async {
    const itemCount = 50;
    final productIds = await insertProducts(itemCount);
    final invoice = buildInvoice(productIds, 1);

    // 1. N+1 Queries (Manual replication of old logic)
    final stopwatchN1 = Stopwatch()..start();
    for (final item in invoice.data.items) {
      final product = await productDao.getById(item.productId);
      if (product == null || product.stockQuantity < item.quantity) {
        throw StateError('Validation failed');
      }
    }
    stopwatchN1.stop();
    print('BENCHMARK_RESULT: N+1 Query validation took: ${stopwatchN1.elapsedMilliseconds}ms for $itemCount items');

    // 2. Optimized: Using the new getByIds
    final stopwatchBatch = Stopwatch()..start();
    final ids = invoice.data.items.map((e) => e.productId).toList();
    final products = await productDao.getByIds(ids);
    final productMap = {for (var p in products) p.id: p};

    for (final item in invoice.data.items) {
      final product = productMap[item.productId];
      if (product == null || product.stockQuantity < item.quantity) {
        throw StateError('Validation failed');
      }
    }
    stopwatchBatch.stop();
    print('BENCHMARK_RESULT: Batch validation took: ${stopwatchBatch.elapsedMilliseconds}ms for $itemCount items');

    expect(stopwatchBatch.elapsedMilliseconds, lessThanOrEqualTo(stopwatchN1.elapsedMilliseconds));
  });
}
