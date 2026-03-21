// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_configuration_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportConfigurationEntry _$ReportConfigurationEntryFromJson(
  Map<String, dynamic> json,
) => ReportConfigurationEntry(
  enableSalesByPeriod: json['enableSalesByPeriod'] as bool,
  enableTopProducts: json['enableTopProducts'] as bool,
  defaultPeriodInDays: (json['defaultPeriodInDays'] as num).toInt(),
  id: (json['id'] as num?)?.toInt(),
  registrationDate: json['registrationDate'] == null
      ? null
      : DateTime.parse(json['registrationDate'] as String),
  lastUpdatedDate: json['lastUpdatedDate'] == null
      ? null
      : DateTime.parse(json['lastUpdatedDate'] as String),
);

Map<String, dynamic> _$ReportConfigurationEntryToJson(
  ReportConfigurationEntry instance,
) => <String, dynamic>{
  'id': instance.id,
  'registrationDate': instance.registrationDate.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
  'enableSalesByPeriod': instance.enableSalesByPeriod,
  'enableTopProducts': instance.enableTopProducts,
  'defaultPeriodInDays': instance.defaultPeriodInDays,
};
