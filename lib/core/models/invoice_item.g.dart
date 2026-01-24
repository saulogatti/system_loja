// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceItem _$InvoiceItemFromJson(Map<String, dynamic> json) => $checkedCreate(
  'InvoiceItem',
  json,
  ($checkedConvert) {
    final val = InvoiceItem(
      productId: $checkedConvert(
        'produto_id',
        (v) => (v as num?)?.toInt() ?? kInvalidId,
      ),
      productName: $checkedConvert('produto_nome', (v) => v as String),
      productCode: $checkedConvert('produto_codigo', (v) => v as String),
      quantity: $checkedConvert('quantidade', (v) => (v as num).toInt()),
      unitPrice: $checkedConvert(
        'preco_unitario',
        (v) => (v as num).toDouble(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'productId': 'produto_id',
    'productName': 'produto_nome',
    'productCode': 'produto_codigo',
    'quantity': 'quantidade',
    'unitPrice': 'preco_unitario',
  },
);

Map<String, dynamic> _$InvoiceItemToJson(InvoiceItem instance) =>
    <String, dynamic>{
      'produto_id': instance.productId,
      'produto_nome': instance.productName,
      'produto_codigo': instance.productCode,
      'quantidade': instance.quantity,
      'preco_unitario': instance.unitPrice,
    };
