const int kInvalidId = -1;

/// Item de nota fiscal (domínio). Serialização em `invoice_item_data.dart`.
class InvoiceItem {
  final int productId;
  final String productName;
  final String productCode;
  final int quantity;
  final double unitPrice;
  final double totalValue;

  InvoiceItem({
    required this.productName,
    required this.productCode,
    required this.quantity,
    required this.unitPrice,
    this.productId = kInvalidId,
  }) : totalValue = quantity * unitPrice;

  @override
  String toString() {
    return '  - ${quantity}x $productName (R\$ ${unitPrice.toStringAsFixed(2)}) = R\$ ${totalValue.toStringAsFixed(2)}';
  }
}
