// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceItem _$InvoiceItemFromJson(Map<String, dynamic> json) => InvoiceItem(
  productId: (json['produto_id'] as num).toInt(),
  productName: json['produto_nome'] as String,
  productCode: json['produto_codigo'] as String,
  quantity: (json['quantidade'] as num).toInt(),
  unitPrice: (json['preco_unitario'] as num).toDouble(),
);

Map<String, dynamic> _$InvoiceItemToJson(InvoiceItem instance) =>
    <String, dynamic>{
      'produto_id': instance.productId,
      'produto_nome': instance.productName,
      'produto_codigo': instance.productCode,
      'quantidade': instance.quantity,
      'preco_unitario': instance.unitPrice,
    };
