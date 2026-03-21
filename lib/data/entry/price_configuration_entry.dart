import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';
import 'package:system_loja/data/entry/report_configuration_entry.dart'
    show ReportConfigurationEntry;

part 'price_configuration_entry.g.dart';

/// Representação JSON de [PriceConfiguration] na camada de dados.
///
/// Gerada com `json_serializable`. Após alterar campos, rode `build_runner`.
@JsonSerializable()
class PriceConfigurationEntry extends PriceConfiguration {
  @override
  @JsonKey(fromJson: ReportConfigurationEntry.fromJson, toJson: toJsonStatic)
  // ignore: overridden_fields
  ReportConfiguration? reportConfiguration;
  PriceConfigurationEntry({
    required super.types,
    required super.measurementUnits,
    @JsonKey(
      fromJson: ReportConfigurationEntry.fromJson,
      toJson: ReportConfigurationEntry.toJsonStatic,
    )
    this.reportConfiguration,
    super.id,
    super.registrationDate,
    super.lastUpdatedDate,
  });
  factory PriceConfigurationEntry.fromJson(Map<String, dynamic> json) =>
      _$PriceConfigurationEntryFromJson(json);
  factory PriceConfigurationEntry.fromPriceConfiguration(
    PriceConfiguration priceConfiguration,
  ) => PriceConfigurationEntry(
    types: priceConfiguration.types,
    measurementUnits: priceConfiguration.measurementUnits,
    reportConfiguration: priceConfiguration.reportConfiguration != null
        ? ReportConfigurationEntry.fromReportConfiguration(
            priceConfiguration.reportConfiguration!,
          )
        : ReportConfigurationEntry.fromReportConfiguration(
            ReportConfiguration(),
          ),
    id: priceConfiguration.id,
    registrationDate: priceConfiguration.registrationDate,
    lastUpdatedDate: priceConfiguration.lastUpdatedDate,
  );
  Map<String, dynamic> toJson() => _$PriceConfigurationEntryToJson(this);
  static ReportConfiguration? fromJsonStatic(Object? object) => object != null
      ? ReportConfigurationEntry.fromReportConfiguration(
          object as ReportConfiguration,
        )
      : null;
  static Map<String, dynamic> toJsonStatic(
    ReportConfiguration? reportConfiguration,
  ) => reportConfiguration != null
      ? ReportConfigurationEntry.toJsonStatic(reportConfiguration)
      : <String, dynamic>{};
}
