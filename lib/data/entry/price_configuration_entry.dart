import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';
import 'package:system_loja/data/entry/report_configuration_entry.dart';

part 'price_configuration_entry.g.dart';

/// DTO JSON para [PriceConfiguration] (sem herdar domínio).
@JsonSerializable()
class PriceConfigurationEntry {
  final List<PaymentMethodType> types;
  final List<String> measurementUnits;
  final ReportConfigurationEntry? reportConfiguration;
  final int id;
  final DateTime registrationDate;
  final DateTime lastUpdatedDate;

  const PriceConfigurationEntry({
    required this.types,
    required this.measurementUnits,
    required this.registrationDate,
    required this.lastUpdatedDate,
    this.reportConfiguration,
    this.id = -1,
  });

  factory PriceConfigurationEntry.fromJson(Map<String, dynamic> json) =>
      _$PriceConfigurationEntryFromJson(json);

  factory PriceConfigurationEntry.fromDomain(
    PriceConfiguration priceConfiguration,
  ) {
    return PriceConfigurationEntry(
      types: priceConfiguration.types,
      measurementUnits: priceConfiguration.measurementUnits,
      reportConfiguration: priceConfiguration.reportConfiguration != null
          ? ReportConfigurationEntry.fromDomain(
              priceConfiguration.reportConfiguration!,
            )
          : ReportConfigurationEntry.fromDomain(ReportConfiguration()),
      id: priceConfiguration.id,
      registrationDate: priceConfiguration.registrationDate,
      lastUpdatedDate: priceConfiguration.lastUpdatedDate,
    );
  }

  Map<String, dynamic> toJson() => _$PriceConfigurationEntryToJson(this);

  PriceConfiguration toDomain() => PriceConfiguration(
    types: types,
    measurementUnits: measurementUnits,
    reportConfiguration:
        reportConfiguration?.toDomain() ?? ReportConfiguration(),
    id: id,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}
