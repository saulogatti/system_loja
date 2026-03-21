import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/data/models/price_configuration_data.dart';

/// Ponte entre [PriceConfiguration] (domínio) e JSON/Drift.
///
/// O contrato JSON é [PriceConfigurationData] (`json_serializable`).
class PriceConfigurationCodec {
  /// Conversor Drift (coluna texto ↔ objeto de domínio).
  static drift.JsonTypeConverter2<PriceConfiguration, String, Object?>
  get driftConverter =>
      drift.TypeConverter.json2(fromJson: fromJson, toJson: toJson);

  PriceConfigurationCodec._();

  /// [json] pode ser `null` quando o mapa pai omite `priceConfiguration`
  /// (ex.: [SystemConfiguration]).
  static PriceConfiguration fromJson(Object? json) {
    if (json == null) {
      return PriceConfiguration.defaultConfiguration();
    }
    final priceConfigurationData = PriceConfigurationData.fromJson(
      json as Map<String, dynamic>,
    );
    return PriceConfiguration(
      types: priceConfigurationData.types,
      measurementUnits: priceConfigurationData.measurementUnits,
      reportConfiguration: priceConfigurationData.reportConfiguration,
    );
  }

  static PriceConfiguration fromJsonString(String raw) =>
      fromJson(jsonDecode(raw) as Map<String, dynamic>);

  static Map<String, dynamic> toJson(PriceConfiguration instance) =>
      PriceConfigurationData.fromPriceConfiguration(instance).toJson();
}
