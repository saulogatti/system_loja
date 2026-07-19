import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';

/// Representa uma movimentacao de produto em uma nota fiscal.
class ProductInvoiceMovement {

  const ProductInvoiceMovement({required this.invoice, required this.item});
  final Invoice invoice;
  final InvoiceItem item;
}
