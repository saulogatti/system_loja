import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/constants/app_constants.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/services/relatorio_overview_service.dart';

void main() {
  late RelatorioOverviewService service;

  setUp(() {
    service = RelatorioOverviewService();
  });

  group('RelatorioOverviewService.buildEstoqueOverview', () {
    test('returns zeros when products list is empty', () {
      final overview = service.buildEstoqueOverview([]);

      expect(overview.totalProdutos, 0);
      expect(overview.produtosSemEstoque, 0);
      expect(overview.produtosComEstoqueBaixo, 0);
      expect(overview.produtosOrdenadosPorEstoque, isEmpty);
    });

    test('calculates correct metrics with various stock levels', () {
      final products = [
        Product(
          name: 'Product A',
          description: 'A',
          price: 10.0,
          stockQuantity: 0,
          code: 'A1',
        ), // No stock
        Product(
          name: 'Product B',
          description: 'B',
          price: 20.0,
          stockQuantity: 0,
          code: 'B1',
        ), // No stock
        Product(
          name: 'Product C',
          description: 'C',
          price: 30.0,
          stockQuantity: 3,
          code: 'C1',
        ), // Low stock (3 <= 5)
        Product(
          name: 'Product D',
          description: 'D',
          price: 40.0,
          stockQuantity: Constants.kLowStockThreshold,
          code: 'D1',
        ), // Low stock (5 <= 5)
        Product(
          name: 'Product E',
          description: 'E',
          price: 50.0,
          stockQuantity: 10,
          code: 'E1',
        ), // Normal stock
      ];

      final overview = service.buildEstoqueOverview(products);

      expect(overview.totalProdutos, 5);
      expect(overview.produtosSemEstoque, 2); // A and B
      expect(overview.produtosComEstoqueBaixo, 2); // C and D
      expect(overview.produtosOrdenadosPorEstoque.length, 5);
    });

    test('sorts products by stock quantity in ascending order', () {
      final products = [
        Product(
          name: 'P1',
          description: 'D1',
          price: 10.0,
          stockQuantity: 10,
          code: 'C1',
        ),
        Product(
          name: 'P2',
          description: 'D2',
          price: 20.0,
          stockQuantity: 2,
          code: 'C2',
        ),
        Product(
          name: 'P3',
          description: 'D3',
          price: 30.0,
          stockQuantity: 5,
          code: 'C3',
        ),
        Product(
          name: 'P4',
          description: 'D4',
          price: 40.0,
          stockQuantity: 0,
          code: 'C4',
        ),
      ];

      final overview = service.buildEstoqueOverview(products);

      final sortedProducts = overview.produtosOrdenadosPorEstoque;
      expect(sortedProducts[0].stockQuantity, 0);
      expect(sortedProducts[1].stockQuantity, 2);
      expect(sortedProducts[2].stockQuantity, 5);
      expect(sortedProducts[3].stockQuantity, 10);
    });

    test('does not modify the original products list', () {
      final products = [
        Product(
          name: 'P1',
          description: 'D1',
          price: 10.0,
          stockQuantity: 10,
          code: 'C1',
        ),
        Product(
          name: 'P2',
          description: 'D2',
          price: 20.0,
          stockQuantity: 2,
          code: 'C2',
        ),
      ];

      final originalOrder = List<Product>.from(products);

      service.buildEstoqueOverview(products);

      expect(products[0].stockQuantity, originalOrder[0].stockQuantity);
      expect(products[1].stockQuantity, originalOrder[1].stockQuantity);
    });
  });
}
