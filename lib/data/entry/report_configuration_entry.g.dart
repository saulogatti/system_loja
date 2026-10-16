// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file
// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_null_checks, unused_element, unnecessary_lambdas, inference_failure_on_collection_literal

part of 'report_configuration_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportConfigurationEntry _$ReportConfigurationEntryFromJson(
  Map<String, dynamic> json,
) => ReportConfigurationEntry(
  registrationDate: DateTime.parse(json['registrationDate'] as String),
  lastUpdatedDate: DateTime.parse(json['lastUpdatedDate'] as String),
  enableSalesByPeriod: json['enableSalesByPeriod'] as bool? ?? true,
  enableTopProducts: json['enableTopProducts'] as bool? ?? true,
  defaultPeriodInDays: (json['defaultPeriodInDays'] as num?)?.toInt() ?? 30,
  id: (json['id'] as num?)?.toInt() ?? -1,
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
