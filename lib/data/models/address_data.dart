import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/address.dart';

part 'address_data.g.dart';

/// DTO JSON de [Address] para import/export e coluna serializada.
///
/// {@category dados}
/// {@subCategory Cadastros}
///
/// Persistência principal é Drift; JSON é só DTO/codec.
@JsonSerializable()
class AddressData {

  const AddressData({
    this.street = '',
    this.zipCode = '',
    this.neighborhood = '',
    this.city = '',
    this.state = '',
  });

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);

  factory AddressData.fromDomain(Address value) => AddressData(
    street: value.street,
    zipCode: value.zipCode,
    neighborhood: value.neighborhood,
    city: value.city,
    state: value.state,
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

  Map<String, dynamic> toJson() => _$AddressDataToJson(this);

  /// Converte o DTO para o modelo de domínio [Address].
  Address toDomain() => Address(
    street: street,
    zipCode: zipCode,
    neighborhood: neighborhood,
    city: city,
    state: state,
  );
}
