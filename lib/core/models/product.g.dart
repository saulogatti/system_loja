// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  name: json['name'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toDouble(),
  stockQuantity: (json['stockQuantity'] as num).toInt(),
  code: json['code'] as String,
  lastUpdatedDate: json['lastUpdatedDate'] == null
      ? null
      : DateTime.parse(json['lastUpdatedDate'] as String),
  categoryId: (json['categoryId'] as num?)?.toInt(),
  id: (json['id'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'stockQuantity': instance.stockQuantity,
  'categoryId': instance.categoryId,
  'code': instance.code,
};
