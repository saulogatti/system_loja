// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntry _$UserEntryFromJson(Map<String, dynamic> json) => UserEntry(
  name: json['name'] as String,
  email: json['email'] as String?,
  passwordHash: json['passwordHash'] as String,
  permission: (json['permission'] as num?)?.toInt() ?? 0,
  registrationDate: DateTime.parse(json['registrationDate'] as String),
  lastUpdatedDate: json['lastUpdatedDate'] == null
      ? null
      : DateTime.parse(json['lastUpdatedDate'] as String),
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$UserEntryToJson(UserEntry instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'passwordHash': instance.passwordHash,
  'permission': instance.permission,
  'registrationDate': instance.registrationDate.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate?.toIso8601String(),
};
