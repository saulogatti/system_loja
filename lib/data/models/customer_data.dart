import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/data/models/address_data.dart';

part 'customer_data.g.dart';

/// DTO JSON de [Customer] para import/export e cache de arquivo.
///
/// {@category dados}
/// {@subCategory Cadastros}
///
/// Persistência principal é Drift em [CustomerRecords].
@JsonSerializable(explicitToJson: true)
class CustomerData {

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
  final int id;
  final String name;
  final String cpf;
  final String? phone;
  final String? email;
  final AddressData address;
  final DateTime registrationDate;
  final DateTime? lastUpdatedDate;

  Map<String, dynamic> toJson() => _$CustomerDataToJson(this);

  /// Converte o DTO para o modelo de domínio [Customer].
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
