import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';
import 'package:system_loja/data/entry/report_configuration_entry.dart'
    show ReportConfigurationEntry;

part 'price_configuration_data.g.dart';

/// Representação JSON de [PriceConfiguration] na camada de dados.
///
/// Gerada com `json_serializable`. Após alterar campos, rode `build_runner`.
@JsonSerializable()
class PriceConfigurationData extends PriceConfiguration {
  @override
  @JsonKey(fromJson: ReportConfigurationEntry.fromJson, toJson: toJsonStatic)
  // ignore: overridden_fields
  ReportConfiguration? reportConfiguration;
  PriceConfigurationData({
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
  factory PriceConfigurationData.fromJson(Map<String, dynamic> json) =>
      _$PriceConfigurationDataFromJson(json);
  factory PriceConfigurationData.fromPriceConfiguration(
    PriceConfiguration priceConfiguration,
  ) => PriceConfigurationData(
    types: priceConfiguration.types,
    measurementUnits: priceConfiguration.measurementUnits,
    reportConfiguration: ReportConfigurationEntry.fromReportConfiguration(
      priceConfiguration.reportConfiguration!,
    ),
  );
  Map<String, dynamic> toJson() => _$PriceConfigurationDataToJson(this);
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
