// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_user_data_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemUserDataEntry _$SystemUserDataEntryFromJson(Map<String, dynamic> json) =>
    SystemUserDataEntry(
      name: json['name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      systemKey: json['systemKey'] as String,
      description: json['description'] as String,
      id: (json['id'] as num?)?.toInt(),
      registrationDate: json['registrationDate'] == null
          ? null
          : DateTime.parse(json['registrationDate'] as String),
      lastUpdatedDate: json['lastUpdatedDate'] == null
          ? null
          : DateTime.parse(json['lastUpdatedDate'] as String),
    );

Map<String, dynamic> _$SystemUserDataEntryToJson(
  SystemUserDataEntry instance,
) => <String, dynamic>{
  'id': instance.id,
  'registrationDate': instance.registrationDate.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'systemKey': instance.systemKey,
  'description': instance.description,
};
