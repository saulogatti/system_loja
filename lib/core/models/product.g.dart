// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Product', json, ($checkedConvert) {
      final val = Product(
        name: $checkedConvert('name', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String),
        price: $checkedConvert('price', (v) => (v as num).toDouble()),
        stockQuantity: $checkedConvert(
          'stockQuantity',
          (v) => (v as num).toInt(),
        ),
        lastUpdatedDate: $checkedConvert(
          'last_updated_date',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        categoryId: $checkedConvert('categoryId', (v) => (v as num?)?.toInt()),
        code: $checkedConvert('code', (v) => v as String),
        id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
      );
      return val;
    }, fieldKeyMap: const {'lastUpdatedDate': 'last_updated_date'});

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'stockQuantity': instance.stockQuantity,
  'categoryId': instance.categoryId,
  'code': instance.code,
};
