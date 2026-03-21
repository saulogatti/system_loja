import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';

part 'report_configuration_entry.g.dart';

@JsonSerializable()
class ReportConfigurationEntry extends ReportConfiguration {
  ReportConfigurationEntry({
    required super.enableSalesByPeriod,
    required super.enableTopProducts,
    required super.defaultPeriodInDays,
    super.id,
    super.registrationDate,
    super.lastUpdatedDate,
  });
  factory ReportConfigurationEntry.fromJson(Map<String, dynamic> json) =>
      _$ReportConfigurationEntryFromJson(json);
  factory ReportConfigurationEntry.fromReportConfiguration(
    ReportConfiguration reportConfiguration,
  ) {
    return ReportConfigurationEntry(
      enableSalesByPeriod: reportConfiguration.enableSalesByPeriod,
      enableTopProducts: reportConfiguration.enableTopProducts,
      defaultPeriodInDays: reportConfiguration.defaultPeriodInDays,
      id: reportConfiguration.id,
      registrationDate: reportConfiguration.registrationDate,
      lastUpdatedDate: reportConfiguration.lastUpdatedDate,
    );
  }
  Map<String, dynamic> toJson() => _$ReportConfigurationEntryToJson(this);
  static Map<String, dynamic> toJsonStatic(
    ReportConfiguration reportConfiguration,
  ) => ReportConfigurationEntry.fromReportConfiguration(
    reportConfiguration,
  ).toJson();
  static ReportConfiguration? toReportConfiguration(
    ReportConfigurationEntry? reportConfigurationEntry,
  ) => reportConfigurationEntry != null
      ? ReportConfiguration(
          enableSalesByPeriod: reportConfigurationEntry.enableSalesByPeriod,
          enableTopProducts: reportConfigurationEntry.enableTopProducts,
          defaultPeriodInDays: reportConfigurationEntry.defaultPeriodInDays,
          id: reportConfigurationEntry.id,
          registrationDate: reportConfigurationEntry.registrationDate,
          lastUpdatedDate: reportConfigurationEntry.lastUpdatedDate,
        )
      : null;
}
