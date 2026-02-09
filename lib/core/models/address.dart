import 'package:drift/drift.dart' as drift;
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  static drift.JsonTypeConverter2<Address, String, Object?> converter =
      drift.TypeConverter.json2(
        fromJson: (json) => Address.fromJson(json as Map<String, Object?>),
        toJson: (address) => address.toJson(),
      );
  @JsonKey(defaultValue: '')
  final String street;
  @JsonKey(defaultValue: '')
  final String zipCode;
  @JsonKey(defaultValue: '')
  final String neighborhood;
  @JsonKey(defaultValue: '')
  final String city;
  @JsonKey(defaultValue: '')
  final String state;

  Address({
    this.street = '',
    this.zipCode = '',
    this.neighborhood = '',
    this.city = '',
    this.state = '',
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
  @override
  String toString() =>
      'Address(street: $street, zipCode: $zipCode, neighborhood: $neighborhood, city: $city, state: $state)';
}
