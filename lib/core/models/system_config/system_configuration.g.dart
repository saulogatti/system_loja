// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemConfiguration _$SystemConfigurationFromJson(Map<String, dynamic> json) =>
    SystemConfiguration(
      priceConfiguration: json['priceConfiguration'] == null
          ? null
          : PriceConfiguration.fromJson(
              json['priceConfiguration'] as Map<String, dynamic>,
            ),
      productCategories: (json['productCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastUpdatedDate: json['last_updated_date'] == null
          ? null
          : DateTime.parse(json['last_updated_date'] as String),
      registrationDate: json['registration_date'] == null
          ? null
          : DateTime.parse(json['registration_date'] as String),
      id: (json['id'] as num?)?.toInt(),
      systemUserData: SystemConfiguration._systemUserDataFromJson(
        json['systemUserData'],
      ),
    );

Map<String, dynamic> _$SystemConfigurationToJson(
  SystemConfiguration instance,
) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'priceConfiguration': instance.priceConfiguration.toJson(),
  'systemUserData': SystemConfiguration._systemUserDataToJson(
    instance.systemUserData,
  ),
  'productCategories': instance.productCategories,
};
