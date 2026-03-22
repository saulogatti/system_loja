import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/data/models/address_data.dart';

part 'customer_data.g.dart';

/// JSON para [Customer].
@JsonSerializable(explicitToJson: true)
class CustomerData {
  final int id;
  final String name;
  final String cpf;
  final String? phone;
  final String? email;
  final AddressData address;
  final DateTime registrationDate;
  final DateTime? lastUpdatedDate;

  const CustomerData({
    required this.id,
    required this.name,
    required this.cpf,
    required this.address,
    required this.registrationDate,
    this.phone,
    this.email,
    this.lastUpdatedDate,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDataToJson(this);

  factory CustomerData.fromDomain(Customer value) => CustomerData(
    id: value.id,
    name: value.name,
    cpf: value.cpf,
    phone: value.phone,
    email: value.email,
    address: AddressData.fromDomain(value.address),
    registrationDate: value.registrationDate,
    lastUpdatedDate: value.lastUpdatedDate,
  );

  Customer toDomain() => Customer(
    id: id,
    name: name,
    cpf: cpf,
    phone: phone,
    email: email,
    address: address.toDomain(),
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}
