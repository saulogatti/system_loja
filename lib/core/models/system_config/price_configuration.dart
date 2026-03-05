import 'package:drift/drift.dart' as drift;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';

part 'price_configuration.g.dart';

enum PaymentMethodType { cash, card, pix, other }

@JsonSerializable()
class PriceConfiguration extends DefaultObject {
  static drift.JsonTypeConverter2<PriceConfiguration, String, Object?> converter = drift.TypeConverter.json2(
    fromJson: (json) => PriceConfiguration.fromJson(json as Map<String, Object?>),
    toJson: (address) => address.toJson(),
  );
  @JsonKey(defaultValue: <PaymentMethodType>[])
  List<PaymentMethodType> types = [];

  @JsonKey(defaultValue: <String>[])
  List<String> measurementUnits = [];

  @JsonKey(fromJson: _reportFromJson, toJson: _reportToJson)
  ReportConfiguration reportConfiguration;

  PriceConfiguration({
    required this.types,
    List<String>? measurementUnits,
    ReportConfiguration? reportConfiguration,
    super.lastUpdatedDate,
    super.registrationDate,
    int? id,
  }) : measurementUnits = measurementUnits ?? [],
       reportConfiguration = reportConfiguration ?? ReportConfiguration(),
       super(id: id ?? -1);

  factory PriceConfiguration.fromJson(Map<String, dynamic> json) => _$PriceConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return _$PriceConfigurationToJson(this);
  }

  static ReportConfiguration _reportFromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ReportConfiguration();
    }
    return ReportConfiguration.fromJson(json);
  }

  static Map<String, dynamic> _reportToJson(ReportConfiguration value) {
    return value.toJson();
  }
}
