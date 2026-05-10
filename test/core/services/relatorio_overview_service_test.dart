import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/constants/app_constants.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/services/relatorio_overview_service.dart';

void main() {
  late RelatorioOverviewService service;

  setUp(() {
    service = RelatorioOverviewService();
  });

  group('RelatorioOverviewService - buildEstoqueOverview', () {
    test('should return empty overview when product list is empty', () {
      final result = service.buildEstoqueOverview([]);

      expect(result.totalProdutos, 0);
      expect(result.produtosSemEstoque, 0);
      expect(result.produtosComEstoqueBaixo, 0);
      expect(result.produtosOrdenadosPorEstoque, isEmpty);
    });

    test('should correctly count products with zero and low stock', () {
      final products = [
        Product(
          name: 'P1',
          description: '',
          price: 10,
          stockQuantity: 0,
          code: 'C1',
        ),
        Product(
          name: 'P2',
          description: '',
          price: 10,
          stockQuantity: 3,
          code: 'C2',
        ),
        Product(
          name: 'P3',
          description: '',
          price: 10,
          stockQuantity: Constants.kLowStockThreshold,
          code: 'C3',
        ),
        Product(
          name: 'P4',
          description: '',
          price: 10,
          stockQuantity: Constants.kLowStockThreshold + 1,
          code: 'C4',
        ),
      ];

      final result = service.buildEstoqueOverview(products);

      expect(result.totalProdutos, 4);
      expect(result.produtosSemEstoque, 1); // Only P1
      expect(result.produtosComEstoqueBaixo, 2); // P2 and P3
    });

    test('should return products sorted by stock quantity', () {
      final products = [
        Product(
          name: 'P1',
          description: '',
          price: 10,
          stockQuantity: 10,
          code: 'C1',
        ),
        Product(
          name: 'P2',
          description: '',
          price: 10,
          stockQuantity: 2,
          code: 'C2',
        ),
        Product(
          name: 'P3',
          description: '',
          price: 10,
          stockQuantity: 5,
          code: 'C3',
        ),
      ];

      final result = service.buildEstoqueOverview(products);

      expect(result.produtosOrdenadosPorEstoque[0].name, 'P2');
      expect(result.produtosOrdenadosPorEstoque[1].name, 'P3');
      expect(result.produtosOrdenadosPorEstoque[2].name, 'P1');
    });
  });

  group('RelatorioOverviewService - buildNotasOverview', () {
    test('should return zeroed overview when invoice maps are empty', () {
      final result = service.buildNotasOverview(
        entryInvoices: {},
        exitInvoices: {},
      );

      expect(result.quantidadeEntradas, 0);
      expect(result.quantidadeSaidas, 0);
      expect(result.totalEntrada, 0.0);
      expect(result.totalSaida, 0.0);
    });

    test('should correctly calculate totals for entry and exit invoices', () {
      final entryInvoices = {
        1: Invoice(
          id: 1,
          data: InvoiceData(
            invoiceNumber: 'E1',
            items: [
              InvoiceItem(
                productName: 'P1',
                productCode: 'C1',
                quantity: 2,
                unitPrice: 50.0,
              ),
            ],
            paymentMethod: 'Money',
            companyId: 100,
            companyName: 'Supplier A',
            type: InvoiceType.entry,
          ),
        ),
      };

      final exitInvoices = {
        2: Invoice(
          id: 2,
          data: InvoiceData(
            invoiceNumber: 'S1',
            items: [
              InvoiceItem(
                productName: 'P1',
                productCode: 'C1',
                quantity: 1,
                unitPrice: 150.0,
              ),
            ],
            paymentMethod: 'Card',
            customerId: 200,
            customerName: 'Client B',
            type: InvoiceType.exit,
          ),
        ),
        3: Invoice(
          id: 3,
          data: InvoiceData(
            invoiceNumber: 'S2',
            items: [
              InvoiceItem(
                productName: 'P2',
                productCode: 'C2',
                quantity: 2,
                unitPrice: 25.0,
              ),
            ],
            paymentMethod: 'Pix',
            customerId: 200,
            customerName: 'Client B',
            type: InvoiceType.exit,
          ),
        ),
      };

      final result = service.buildNotasOverview(
        entryInvoices: entryInvoices,
        exitInvoices: exitInvoices,
      );

      expect(result.quantidadeEntradas, 1);
      expect(result.quantidadeSaidas, 2);
      expect(result.totalEntrada, 100.0);
      expect(result.totalSaida, 200.0); // 150 + (2 * 25)
    });
  });
}
