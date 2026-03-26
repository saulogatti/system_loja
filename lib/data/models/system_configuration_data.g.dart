// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_configuration_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemConfigurationData _$SystemConfigurationDataFromJson(Map<String, dynamic> json) =>
    SystemConfigurationData(
      id: (json['id'] as num).toInt(),
      registrationDate: DateTime.parse(json['registrationDate'] as String),
      lastUpdatedDate: DateTime.parse(json['lastUpdatedDate'] as String),
      priceConfiguration: PriceConfigurationCodec.fromJson(json['priceConfiguration']),
      productCategories:
          (json['productCategories'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      systemUserData: SystemConfigurationData._systemUserDataFromJson(json['systemUserData']),
    );

Map<String, dynamic> _$SystemConfigurationDataToJson(SystemConfigurationData instance) => <String, dynamic>{
  'id': instance.id,
  'registrationDate': instance.registrationDate.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
  'priceConfiguration': PriceConfigurationCodec.toJson(instance.priceConfiguration),
  'productCategories': instance.productCategories,
  'systemUserData': SystemConfigurationData._systemUserDataToJson(instance.systemUserData),
};
