// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_user_data_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemUserDataEntry _$SystemUserDataEntryFromJson(Map<String, dynamic> json) =>
    SystemUserDataEntry(
      systemKey: json['systemKey'] as String,
      description: json['description'] as String,
      person: IndividualEntry.fromJson(json['person'] as Map<String, dynamic>),
      id: (json['id'] as num?)?.toInt(),
      registrationDate: json['registration_date'] == null
          ? null
          : DateTime.parse(json['registration_date'] as String),
      lastUpdatedDate: json['last_updated_date'] == null
          ? null
          : DateTime.parse(json['last_updated_date'] as String),
    );

Map<String, dynamic> _$SystemUserDataEntryToJson(
  SystemUserDataEntry instance,
) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'systemKey': instance.systemKey,
  'description': instance.description,
  'person': instance.person,
};
