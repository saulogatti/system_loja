// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceItemData _$InvoiceItemDataFromJson(Map<String, dynamic> json) => InvoiceItemData(
  productName: json['produto_nome'] as String,
  productCode: json['produto_codigo'] as String,
  quantity: (json['quantidade'] as num).toInt(),
  unitPrice: (json['preco_unitario'] as num).toDouble(),
  productId: (json['produto_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$InvoiceItemDataToJson(InvoiceItemData instance) => <String, dynamic>{
  'produto_id': instance.productId,
  'produto_nome': instance.productName,
  'produto_codigo': instance.productCode,
  'quantidade': instance.quantity,
  'preco_unitario': instance.unitPrice,
};
