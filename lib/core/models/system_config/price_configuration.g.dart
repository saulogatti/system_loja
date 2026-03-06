// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceConfiguration _$PriceConfigurationFromJson(Map<String, dynamic> json) =>
    PriceConfiguration(
      types:
          (json['types'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PaymentMethodTypeEnumMap, e))
              .toList() ??
          [],
      measurementUnits:
          (json['measurementUnits'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      reportConfiguration: PriceConfiguration._reportFromJson(
        json['reportConfiguration'] as Map<String, dynamic>?,
      ),
      lastUpdatedDate: json['last_updated_date'] == null
          ? null
          : DateTime.parse(json['last_updated_date'] as String),
      registrationDate: json['registration_date'] == null
          ? null
          : DateTime.parse(json['registration_date'] as String),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PriceConfigurationToJson(
  PriceConfiguration instance,
) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'types': instance.types.map((e) => _$PaymentMethodTypeEnumMap[e]!).toList(),
  'measurementUnits': instance.measurementUnits,
  'reportConfiguration': PriceConfiguration._reportToJson(
    instance.reportConfiguration,
  ),
};

const _$PaymentMethodTypeEnumMap = {
  PaymentMethodType.cash: 'cash',
  PaymentMethodType.card: 'card',
  PaymentMethodType.pix: 'pix',
  PaymentMethodType.other: 'other',
};
