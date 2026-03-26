// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toDouble(),
  stockQuantity: (json['stockQuantity'] as num).toInt(),
  code: json['code'] as String,
  registrationDate: DateTime.parse(json['registrationDate'] as String),
  categoryId: (json['categoryId'] as num?)?.toInt(),
  lastUpdatedDate: json['lastUpdatedDate'] == null ? null : DateTime.parse(json['lastUpdatedDate'] as String),
);

Map<String, dynamic> _$ProductDataToJson(ProductData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'stockQuantity': instance.stockQuantity,
  'categoryId': instance.categoryId,
  'code': instance.code,
  'registrationDate': instance.registrationDate.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate?.toIso8601String(),
};
