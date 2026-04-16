import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/report/product_invoice_movement.dart';
import 'package:system_loja/core/models/report/product_movement_summary.dart';

/// Serviço para consolidar movimentações de produto em notas.
class ProductMovementReportService {
  /// Monta a lista de movimentações de um [product] dentro de [invoices].
  List<ProductInvoiceMovement> buildMovements(
    Map<int, Invoice> invoices,
    Product product,
  ) {
    final movements = <ProductInvoiceMovement>[];
    final hasValidProductId = product.id > 0;

    for (final invoice in invoices.values) {
      for (final item in invoice.data.items) {
        final matchesById = hasValidProductId && item.productId == product.id;
        final matchesByCode = item.productCode == product.code;
        if (matchesById || matchesByCode) {
          movements.add(ProductInvoiceMovement(invoice: invoice, item: item));
        }
      }
    }

    movements.sort(
      (a, b) => b.invoice.data.issueDate.compareTo(a.invoice.data.issueDate),
    );
    return movements;
  }

  /// Calcula totais e saldo a partir de listas de entradas e saídas.
  ProductMovementSummary summarize({
    required List<ProductInvoiceMovement> entradas,
    required List<ProductInvoiceMovement> saidas,
  }) {
      ProductMovementSummary summarize({
    required List<ProductInvoiceMovement> entries,
    required List<ProductInvoiceMovement> exits,
  }) {
    final totalEntryQuantity = entries.fold<int>(
      0,
      (sum, movement) => sum + movement.item.quantity,
    );
    final totalExitQuantity = exits.fold<int>(
      0,
      (sum, movement) => sum + movement.item.quantity,
    );
    final totalEntryValue = entries.fold<double>(
      0,
      (sum, movement) => sum + movement.item.totalValue,
    );
    final totalExitValue = exits.fold<double>(
      0,
      (sum, movement) => sum + movement.item.totalValue,
    );

    return ProductMovementSummary(
      totalEntryQuantity: totalEntryQuantity,
      totalExitQuantity: totalExitQuantity,
      totalEntryValue: totalEntryValue,
      totalExitValue: totalExitValue,
      balanceQuantity: totalEntryQuantity - totalExitQuantity,
      balanceValue: totalEntryValue - totalExitValue,
    );
  }
}
