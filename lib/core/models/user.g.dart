// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => $checkedCreate(
  'User',
  json,
  ($checkedConvert) {
    final val = User(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      name: $checkedConvert('name', (v) => v as String),
      email: $checkedConvert('email', (v) => v as String?),
      passwordHash: $checkedConvert('senha_hash', (v) => v as String),
      permission: $checkedConvert(
        'nivel_permissao',
        (v) => (v as num?)?.toInt() ?? 0,
      ),
      registrationDate: $checkedConvert(
        'registration_date',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      lastUpdatedDate: $checkedConvert(
        'last_updated_date',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'passwordHash': 'senha_hash',
    'permission': 'nivel_permissao',
    'registrationDate': 'registration_date',
    'lastUpdatedDate': 'last_updated_date',
  },
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'name': instance.name,
  'email': instance.email,
  'senha_hash': instance.passwordHash,
  'nivel_permissao': instance.permission,
};
