// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  name: json['name'] as String,
  description: json['description'] as String?,
  lastUpdatedDate: json['lastUpdatedDate'] == null
      ? null
      : DateTime.parse(json['lastUpdatedDate'] as String),
  id: (json['id'] as num?)?.toInt(),
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
  'name': instance.name,
  'description': instance.description,
};
