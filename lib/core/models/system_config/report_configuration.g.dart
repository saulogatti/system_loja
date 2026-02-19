// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportConfiguration _$ReportConfigurationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReportConfiguration', json, ($checkedConvert) {
      final val = ReportConfiguration(
        enableSalesByPeriod: $checkedConvert(
          'enableSalesByPeriod',
          (v) => v as bool? ?? true,
        ),
        enableTopProducts: $checkedConvert(
          'enableTopProducts',
          (v) => v as bool? ?? true,
        ),
        defaultPeriodInDays: $checkedConvert(
          'defaultPeriodInDays',
          (v) => (v as num?)?.toInt() ?? 30,
        ),
      );
      return val;
    });

Map<String, dynamic> _$ReportConfigurationToJson(
  ReportConfiguration instance,
) => <String, dynamic>{
  'enableSalesByPeriod': instance.enableSalesByPeriod,
  'enableTopProducts': instance.enableTopProducts,
  'defaultPeriodInDays': instance.defaultPeriodInDays,
};
