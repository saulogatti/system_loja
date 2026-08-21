import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/data/database/table/invoice_items_records.dart';

part 'invoice_item_data.g.dart';

/// DTO JSON de [InvoiceItem] para import/export e cache de arquivo.
///
/// {@category dados}
/// {@subCategory Vendas}
///
/// Persistência principal é Drift em [InvoiceItemsRecords].
@JsonSerializable()
class InvoiceItemData {

  const InvoiceItemData({
    required this.productName,
    required this.productCode,
    required this.quantity,
    required this.unitPrice,
    this.productId,
  });

  factory InvoiceItemData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemDataFromJson(json);

  factory InvoiceItemData.fromDomain(InvoiceItem value) => InvoiceItemData(
    productId: value.productId == kInvalidId ? null : value.productId,
    productName: value.productName,
    productCode: value.productCode,
    quantity: value.quantity,
    unitPrice: value.unitPrice,
  );
  @JsonKey(name: 'produto_id')
  final int? productId;
  @JsonKey(name: 'produto_nome')
  final String productName;
  @JsonKey(name: 'produto_codigo')
  final String productCode;
  @JsonKey(name: 'quantidade')
  final int quantity;
  @JsonKey(name: 'preco_unitario')
  final double unitPrice;

  Map<String, dynamic> toJson() => _$InvoiceItemDataToJson(this);

  /// Converte o DTO para o modelo de domínio [InvoiceItem].
  InvoiceItem toDomain() => InvoiceItem(
    productId: productId ?? kInvalidId,
    productName: productName,
    productCode: productCode,
    quantity: quantity,
    unitPrice: unitPrice,
  );
}
