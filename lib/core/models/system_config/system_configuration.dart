import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';

part 'system_configuration.g.dart';

@JsonSerializable()
class SystemConfiguration extends DefaultObject {
  PriceConfiguration priceConfiguration = PriceConfiguration();

  List<String> productCategories = [];
  SystemConfiguration({
    PriceConfiguration? priceConfiguration,
    List<String>? productCategories,
    super.lastUpdatedDate,
    super.registrationDate,
    int? id,
  }) : priceConfiguration = priceConfiguration ?? PriceConfiguration(),
       productCategories = productCategories ?? [],
       super(id: id ?? -1);
  factory SystemConfiguration.fromJson(Map<String, dynamic> json) =>
      _$SystemConfigurationFromJson(json);
  SystemConfiguration copyWith({
    PriceConfiguration? priceConfiguration,
    List<String>? productCategories,

    int? id,
  }) {
    return SystemConfiguration(
      priceConfiguration: priceConfiguration ?? this.priceConfiguration,
      productCategories: productCategories ?? this.productCategories,
      lastUpdatedDate: lastUpdatedDate,
      registrationDate: registrationDate,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, dynamic> toJson() => _$SystemConfigurationToJson(this);
}
