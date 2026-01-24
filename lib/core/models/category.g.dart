// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Category', json, ($checkedConvert) {
      final val = Category(
        name: $checkedConvert('name', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        lastUpdatedDate: $checkedConvert(
          'last_updated_date',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
      );
      return val;
    }, fieldKeyMap: const {'lastUpdatedDate': 'last_updated_date'});

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'last_updated_date': instance.lastUpdatedDate?.toIso8601String(),
  'name': instance.name,
  'description': instance.description,
};
