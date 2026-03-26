// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  registrationDate: DateTime.parse(json['registrationDate'] as String),
  description: json['description'] as String?,
  lastUpdatedDate: json['lastUpdatedDate'] == null ? null : DateTime.parse(json['lastUpdatedDate'] as String),
);

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'registrationDate': instance.registrationDate.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate?.toIso8601String(),
};
