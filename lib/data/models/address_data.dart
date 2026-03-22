import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/address.dart';

part 'address_data.g.dart';

/// Representação JSON de [Address].
@JsonSerializable()
class AddressData {
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

  const AddressData({
    this.street = '',
    this.zipCode = '',
    this.neighborhood = '',
    this.city = '',
    this.state = '',
  });

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataToJson(this);

  factory AddressData.fromDomain(Address value) => AddressData(
    street: value.street,
    zipCode: value.zipCode,
    neighborhood: value.neighborhood,
    city: value.city,
    state: value.state,
  );

  Address toDomain() => Address(
    street: street,
    zipCode: zipCode,
    neighborhood: neighborhood,
    city: city,
    state: state,
  );
}
