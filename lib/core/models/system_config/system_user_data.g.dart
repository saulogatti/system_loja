// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemUserData _$SystemUserDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SystemUserData',
      json,
      ($checkedConvert) {
        final val = SystemUserData(
          name: $checkedConvert('name', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String),
          systemKey: $checkedConvert('systemKey', (v) => v as String),
          id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
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
        'registrationDate': 'registration_date',
        'lastUpdatedDate': 'last_updated_date',
      },
    );

Map<String, dynamic> _$SystemUserDataToJson(SystemUserData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'registration_date': instance.registrationDate.toIso8601String(),
      'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'systemKey': instance.systemKey,
    };
