import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';

part 'report_configuration_entry.g.dart';

/// DTO JSON para [ReportConfiguration] (sem herdar domínio).
@JsonSerializable()
class ReportConfigurationEntry {
  final bool enableSalesByPeriod;
  final bool enableTopProducts;
  final int defaultPeriodInDays;
  final int id;
  final DateTime registrationDate;
  final DateTime lastUpdatedDate;

  const ReportConfigurationEntry({
    required this.registrationDate,
    required this.lastUpdatedDate,
    this.enableSalesByPeriod = true,
    this.enableTopProducts = true,
    this.defaultPeriodInDays = 30,
    this.id = -1,
  });

  factory ReportConfigurationEntry.fromJson(Map<String, dynamic> json) =>
      _$ReportConfigurationEntryFromJson(json);

  factory ReportConfigurationEntry.fromDomain(ReportConfiguration reportConfiguration) {
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

  ReportConfiguration toDomain() => ReportConfiguration(
    enableSalesByPeriod: enableSalesByPeriod,
    enableTopProducts: enableTopProducts,
    defaultPeriodInDays: defaultPeriodInDays,
    id: id,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );

  static Map<String, dynamic> toJsonStatic(ReportConfiguration reportConfiguration) =>
      ReportConfigurationEntry.fromDomain(reportConfiguration).toJson();
}
