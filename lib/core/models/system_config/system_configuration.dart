import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';

part 'system_configuration.g.dart';

@JsonSerializable()
class SystemConfiguration extends DefaultObject {
  PriceConfiguration priceConfiguration = PriceConfiguration(types: []);
  SystemUserData systemUserData;
  List<String> productCategories = [];
  SystemConfiguration({
    PriceConfiguration? priceConfiguration,
    List<String>? productCategories,
    super.lastUpdatedDate,
    super.registrationDate,
    int? id,
    SystemUserData? systemUserData,
  }) : priceConfiguration = priceConfiguration ?? PriceConfiguration(types: []),
       productCategories = productCategories ?? [],
       systemUserData = systemUserData ?? SystemUserData(name: '', email: '', systemKey: '');
  factory SystemConfiguration.fromJson(Map<String, dynamic> json) => _$SystemConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SystemConfigurationToJson(this);
}
