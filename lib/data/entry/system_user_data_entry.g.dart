// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_user_data_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemUserDataEntry _$SystemUserDataEntryFromJson(Map<String, dynamic> json) => SystemUserDataEntry(
  name: json['name'] as String,
  systemKey: json['systemKey'] as String,
  description: json['description'] as String,
  registrationDate: DateTime.parse(json['registrationDate'] as String),
  lastUpdatedDate: DateTime.parse(json['lastUpdatedDate'] as String),
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  id: (json['id'] as num?)?.toInt() ?? -1,
);

Map<String, dynamic> _$SystemUserDataEntryToJson(SystemUserDataEntry instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'systemKey': instance.systemKey,
  'description': instance.description,
  'id': instance.id,
  'registrationDate': instance.registrationDate.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
};
