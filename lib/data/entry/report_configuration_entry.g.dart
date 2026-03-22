// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_configuration_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportConfigurationEntry _$ReportConfigurationEntryFromJson(
  Map<String, dynamic> json,
) => ReportConfigurationEntry(
  enableSalesByPeriod: json['enableSalesByPeriod'] as bool? ?? true,
  enableTopProducts: json['enableTopProducts'] as bool? ?? true,
  defaultPeriodInDays: (json['defaultPeriodInDays'] as num?)?.toInt() ?? 30,
  id: (json['id'] as num?)?.toInt() ?? -1,
  registrationDate: DateTime.parse(json['registrationDate'] as String),
  lastUpdatedDate: DateTime.parse(json['lastUpdatedDate'] as String),
);

Map<String, dynamic> _$ReportConfigurationEntryToJson(
  ReportConfigurationEntry instance,
) => <String, dynamic>{
  'enableSalesByPeriod': instance.enableSalesByPeriod,
  'enableTopProducts': instance.enableTopProducts,
  'defaultPeriodInDays': instance.defaultPeriodInDays,
  'id': instance.id,
  'registrationDate': instance.registrationDate.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
};
