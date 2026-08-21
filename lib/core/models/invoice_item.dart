/// ID sentinela quando o item não está vinculado a um produto persistido.
///
/// {@category modelos}
/// {@subCategory Vendas}
const int kInvalidId = -1;

/// Item de nota fiscal (domínio).
///
/// {@category modelos}
/// {@subCategory Vendas}
///
/// Serialização em `lib/data/models/invoice_item_data.dart`.
class InvoiceItem {
  InvoiceItem({
    required this.productName,
    required this.productCode,
    required this.quantity,
    required this.unitPrice,
    this.productId = kInvalidId,
  }) : totalValue = quantity * unitPrice;
  /// ID do produto; [kInvalidId] quando o vínculo não se aplica.
  final int productId;

  /// Nome do produto no momento da emissão.
  final String productName;

  /// Código do produto no momento da emissão.
  final String productCode;

  /// Quantidade movimentada.
  final int quantity;

  /// Preço unitário na emissão.
  final double unitPrice;

  /// Valor total (`quantity * unitPrice`).
  final double totalValue;

  @override
  String toString() =>
      '  - ${quantity}x $productName (R\$ ${unitPrice.toStringAsFixed(2)}) = R\$ ${totalValue.toStringAsFixed(2)}';
}
