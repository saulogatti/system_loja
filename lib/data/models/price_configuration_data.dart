import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';

part 'price_configuration_data.g.dart';

/// Representação JSON de [PriceConfiguration] na camada de dados.
///
/// Gerada com `json_serializable`. Após alterar campos, rode `build_runner`.
@JsonSerializable(explicitToJson: true)
class PriceConfigurationData {
  final int id;
  final DateTime registrationDate;
  final DateTime lastUpdatedDate;

  @JsonKey(defaultValue: <PaymentMethodType>[])
  final List<PaymentMethodType> types;

  @JsonKey(defaultValue: <String>[])
  final List<String> measurementUnits;

  @JsonKey(fromJson: _reportFromJson, toJson: _reportToJson)
  final ReportConfiguration reportConfiguration;

  PriceConfigurationData({
    required this.id,
    required this.registrationDate,
    required this.lastUpdatedDate,
    required this.types,
    required this.measurementUnits,
    required this.reportConfiguration,
  });

  factory PriceConfigurationData.fromJson(Map<String, dynamic> json) =>
      _$PriceConfigurationDataFromJson(json);

  Map<String, dynamic> toJson() => _$PriceConfigurationDataToJson(this);

  factory PriceConfigurationData.fromDomain(PriceConfiguration value) {
    return PriceConfigurationData(
      id: value.id,
      registrationDate: value.registrationDate,
      lastUpdatedDate: value.lastUpdatedDate,
      types: List<PaymentMethodType>.from(value.types),
      measurementUnits: List<String>.from(value.measurementUnits),
      reportConfiguration: value.reportConfiguration,
    );
  }

  PriceConfiguration toDomain() {
    return PriceConfiguration(
      types: List<PaymentMethodType>.from(types),
      measurementUnits: List<String>.from(measurementUnits),
      reportConfiguration: reportConfiguration,
      id: id,
      registrationDate: registrationDate,
      lastUpdatedDate: lastUpdatedDate,
    );
  }

  static ReportConfiguration _reportFromJson(Object? json) =>
      ReportConfiguration.fromJson(json as Map<String, dynamic>);

  static Map<String, dynamic> _reportToJson(ReportConfiguration value) =>
      value.toJson();
}
