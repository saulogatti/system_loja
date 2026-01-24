import 'package:json_annotation/json_annotation.dart';

part 'invoice_item.g.dart';

const int kInvalidId = -1;

@JsonSerializable()
/// Modelo de dados para Item da Nota Fiscal
class InvoiceItem {
  @JsonKey(name: 'produto_id')
  final int productId;
  @JsonKey(name: 'produto_nome')
  final String productName;
  @JsonKey(name: 'produto_codigo')
  final String productCode;
  @JsonKey(name: 'quantidade')
  final int quantity;
  @JsonKey(name: 'preco_unitario')
  final double unitPrice;
  @JsonKey(name: 'valor_total')
  final double totalValue;

  InvoiceItem({
    this.productId = kInvalidId,
    required this.productName,
    required this.productCode,
    required this.quantity,
    required this.unitPrice,
  }) : totalValue = quantity * unitPrice;

  /// Cria um objeto a partir de JSON
  factory InvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemFromJson(json);

  /// Converte o objeto para JSON
  Map<String, dynamic> toJson() => _$InvoiceItemToJson(this);

  @override
  String toString() {
    return '  - ${quantity}x $productName (R\$ ${unitPrice.toStringAsFixed(2)}) = R\$ ${totalValue.toStringAsFixed(2)}';
  }
}
