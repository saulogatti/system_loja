// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  name: json['name'] as String,
  description: json['description'] as String?,
  lastUpdatedDate: json['last_updated_date'] == null
      ? null
      : DateTime.parse(json['last_updated_date'] as String),
  id: (json['id'] as num?)?.toInt(),
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'name': instance.name,
  'description': instance.description,
};
