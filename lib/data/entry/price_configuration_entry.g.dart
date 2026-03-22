// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_configuration_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceConfigurationEntry _$PriceConfigurationEntryFromJson(
  Map<String, dynamic> json,
) => PriceConfigurationEntry(
  types: (json['types'] as List<dynamic>)
      .map((e) => $enumDecode(_$PaymentMethodTypeEnumMap, e))
      .toList(),
  measurementUnits: (json['measurementUnits'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  reportConfiguration: json['reportConfiguration'] == null
      ? null
      : ReportConfigurationEntry.fromJson(
          json['reportConfiguration'] as Map<String, dynamic>,
        ),
  id: (json['id'] as num?)?.toInt() ?? -1,
  registrationDate: DateTime.parse(json['registrationDate'] as String),
  lastUpdatedDate: DateTime.parse(json['lastUpdatedDate'] as String),
);

Map<String, dynamic> _$PriceConfigurationEntryToJson(
  PriceConfigurationEntry instance,
) => <String, dynamic>{
  'types': instance.types.map((e) => _$PaymentMethodTypeEnumMap[e]!).toList(),
  'measurementUnits': instance.measurementUnits,
  'reportConfiguration': instance.reportConfiguration,
  'id': instance.id,
  'registrationDate': instance.registrationDate.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
};

const _$PaymentMethodTypeEnumMap = {
  PaymentMethodType.cash: 'cash',
  PaymentMethodType.card: 'card',
  PaymentMethodType.pix: 'pix',
  PaymentMethodType.other: 'other',
};
