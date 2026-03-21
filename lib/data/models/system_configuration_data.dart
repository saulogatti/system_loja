import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';
import 'package:system_loja/data/converter/price_configuration_codec.dart';
import 'package:system_loja/data/entry/system_user_data_entry.dart';

part 'system_configuration_data.g.dart';

/// JSON para [SystemConfiguration].
@JsonSerializable(explicitToJson: true)
class SystemConfigurationData {
  final int id;
  final DateTime registrationDate;
  final DateTime lastUpdatedDate;

  @JsonKey(
    fromJson: PriceConfigurationCodec.fromJson,
    toJson: PriceConfigurationCodec.toJson,
  )
  final PriceConfiguration priceConfiguration;

  @JsonKey(defaultValue: <String>[])
  final List<String> productCategories;

  @JsonKey(
    fromJson: _systemUserDataFromJson,
    toJson: _systemUserDataToJson,
    includeIfNull: false,
  )
  final SystemUserData systemUserData;

  SystemConfigurationData({
    required this.id,
    required this.registrationDate,
    required this.lastUpdatedDate,
    required this.priceConfiguration,
    required this.productCategories,
    required this.systemUserData,
  });

  factory SystemConfigurationData.fromJson(Map<String, dynamic> json) =>
      _$SystemConfigurationDataFromJson(json);

  Map<String, dynamic> toJson() => _$SystemConfigurationDataToJson(this);

  factory SystemConfigurationData.fromDomain(SystemConfiguration value) {
    return SystemConfigurationData(
      id: value.id,
      registrationDate: value.registrationDate,
      lastUpdatedDate: value.lastUpdatedDate,
      priceConfiguration: value.priceConfiguration,
      productCategories: List<String>.from(value.productCategories),
      systemUserData: value.systemUserData,
    );
  }

  SystemConfiguration toDomain() {
    return SystemConfiguration(
      id: id,
      registrationDate: registrationDate,
      lastUpdatedDate: lastUpdatedDate,
      priceConfiguration: priceConfiguration,
      productCategories: List<String>.from(productCategories),
      systemUserData: systemUserData,
    );
  }

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
