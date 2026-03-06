// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportConfiguration _$ReportConfigurationFromJson(Map<String, dynamic> json) =>
    ReportConfiguration(
      enableSalesByPeriod: json['enableSalesByPeriod'] as bool? ?? true,
      enableTopProducts: json['enableTopProducts'] as bool? ?? true,
      defaultPeriodInDays: (json['defaultPeriodInDays'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$ReportConfigurationToJson(
  ReportConfiguration instance,
) => <String, dynamic>{
  'enableSalesByPeriod': instance.enableSalesByPeriod,
  'enableTopProducts': instance.enableTopProducts,
  'defaultPeriodInDays': instance.defaultPeriodInDays,
};
