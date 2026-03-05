// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemConfiguration _$SystemConfigurationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SystemConfiguration',
      json,
      ($checkedConvert) {
        final val = SystemConfiguration(
          priceConfiguration: $checkedConvert(
            'priceConfiguration',
            (v) => v == null
                ? null
                : PriceConfiguration.fromJson(v as Map<String, dynamic>),
          ),
          productCategories: $checkedConvert(
            'productCategories',
            (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
          ),
          lastUpdatedDate: $checkedConvert(
            'last_updated_date',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          registrationDate: $checkedConvert(
            'registration_date',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
          systemUserData: $checkedConvert(
            'systemUserData',
            (v) => v == null
                ? null
                : SystemUserData.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'lastUpdatedDate': 'last_updated_date',
        'registrationDate': 'registration_date',
      },
    );

Map<String, dynamic> _$SystemConfigurationToJson(
  SystemConfiguration instance,
) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'priceConfiguration': instance.priceConfiguration.toJson(),
  'systemUserData': instance.systemUserData.toJson(),
  'productCategories': instance.productCategories,
};
