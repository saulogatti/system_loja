const int kInvalidId = -1;

/// Item de nota fiscal (domínio). Serialização em `invoice_item_data.dart`.
class InvoiceItem {
  InvoiceItem({
    required this.productName,
    required this.productCode,
    required this.quantity,
    required this.unitPrice,
    this.productId = kInvalidId,
  }) : totalValue = quantity * unitPrice;
  final int productId;
  final String productName;
  final String productCode;
  final int quantity;
  final double unitPrice;
  final double totalValue;

  @override
  String toString() =>
      '  - ${quantity}x $productName (R\$ ${unitPrice.toStringAsFixed(2)}) = R\$ ${totalValue.toStringAsFixed(2)}';
}
