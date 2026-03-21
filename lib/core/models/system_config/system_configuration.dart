import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';
import 'package:system_loja/data/converter/price_configuration_codec.dart';
import 'package:system_loja/data/entry/system_user_data_entry.dart';

part 'system_configuration.g.dart';

@JsonSerializable(explicitToJson: true)
class SystemConfiguration extends DefaultObject {
  @JsonKey(
    fromJson: PriceConfigurationCodec.fromJson,
    toJson: PriceConfigurationCodec.toJson,
  )
  PriceConfiguration priceConfiguration = PriceConfiguration(
    types: [],
    measurementUnits: [],
    reportConfiguration: ReportConfiguration(),
  );
  @JsonKey(
    fromJson: _systemUserDataFromJson,
    toJson: _systemUserDataToJson,
    includeIfNull: false,
  )
  SystemUserData systemUserData;
  List<String> productCategories = [];

  SystemConfiguration({
    PriceConfiguration? priceConfiguration,
    List<String>? productCategories,
    super.lastUpdatedDate,
    super.registrationDate,
    int? id,
    SystemUserData? systemUserData,
  }) : priceConfiguration =
           priceConfiguration ??
           PriceConfiguration(
             types: [],
             measurementUnits: [],
             reportConfiguration: ReportConfiguration(),
           ),
       productCategories = productCategories ?? [],
       systemUserData = systemUserData ?? SystemUserData.defaultObject();

  factory SystemConfiguration.fromJson(Map<String, dynamic> json) =>
      _$SystemConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$SystemConfigurationToJson(this);

  static SystemUserData _systemUserDataFromJson(Object? json) {
    if (json == null || json is! Map<String, dynamic>) {
      return SystemUserData.defaultObject();
    }
    return SystemUserDataEntry.fromJson(json);
  }

  static Map<String, dynamic> _systemUserDataToJson(SystemUserData value) =>
      value is SystemUserDataEntry
      ? value.toJson()
      : SystemUserDataEntry.fromSystemUserData(value).toJson();
}
