import 'package:system_loja/core/models/product.dart';

/// Linha de item na tela de criação de nota fiscal (produto + quantidade).
class InvoiceLineEntry {
  const InvoiceLineEntry({required this.product, required this.quantity});

  final Product product;
  final int quantity;
}
