// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemConfiguration _$SystemConfigurationFromJson(Map<String, dynamic> json) =>
    SystemConfiguration(
      priceConfiguration: PriceConfigurationCodec.fromJson(
        json['priceConfiguration'],
      ),
      productCategories: (json['productCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastUpdatedDate: json['lastUpdatedDate'] == null
          ? null
          : DateTime.parse(json['lastUpdatedDate'] as String),
      registrationDate: json['registrationDate'] == null
          ? null
          : DateTime.parse(json['registrationDate'] as String),
      id: (json['id'] as num?)?.toInt(),
      systemUserData: SystemConfiguration._systemUserDataFromJson(
        json['systemUserData'],
      ),
    );

Map<String, dynamic> _$SystemConfigurationToJson(
  SystemConfiguration instance,
) => <String, dynamic>{
  'id': instance.id,
  'registrationDate': instance.registrationDate.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
  'priceConfiguration': PriceConfigurationCodec.toJson(
    instance.priceConfiguration,
  ),
  'systemUserData': SystemConfiguration._systemUserDataToJson(
    instance.systemUserData,
  ),
  'productCategories': instance.productCategories,
};
