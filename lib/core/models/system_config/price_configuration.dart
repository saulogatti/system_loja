import 'package:drift/drift.dart' as drift;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'price_configuration.g.dart';

enum PaymentMethodType { cash, card, pix, other }

@JsonSerializable()
class PriceConfiguration extends DefaultObject {
  static drift.JsonTypeConverter2<PriceConfiguration, String, Object?>
  converter = drift.TypeConverter.json2(
    fromJson: (json) =>
        PriceConfiguration.fromJson(json as Map<String, Object?>),
    toJson: (address) => address.toJson(),
  );
  List<PaymentMethodType> types = [];
  PriceConfiguration({
    required this.types,
    super.lastUpdatedDate,
    super.registrationDate,
    int? id,
  }) : super(id: id ?? -1);
  factory PriceConfiguration.fromJson(Map<String, dynamic> json) =>
      _$PriceConfigurationFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    return _$PriceConfigurationToJson(this);
  }
}
