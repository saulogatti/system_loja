import 'package:system_loja/core/models/report/product_invoice_movement.dart';
import 'package:system_loja/core/models/report/product_movement_summary.dart';

/// Dados prontos para renderizar o detalhe de produto no relatório.
class ProductDetailsReportData {
  final String categoryName;
  final List<ProductInvoiceMovement> entries;
  final List<ProductInvoiceMovement> exits;
  final ProductMovementSummary summary;

  const ProductDetailsReportData({
    required this.categoryName,
    required this.entries,
    required this.exits,
    required this.summary,
  });
}
