import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/data/models/address_data.dart';

part 'company_data.g.dart';

/// JSON para [Company].
@JsonSerializable(explicitToJson: true)
class CompanyData {

  const CompanyData({
    required this.id,
    required this.name,
    required this.cnpj,
    required this.address,
    required this.registrationDate,
    this.phone,
    this.email,
    this.lastUpdatedDate,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) =>
      _$CompanyDataFromJson(json);

  factory CompanyData.fromDomain(Company value) => CompanyData(
    id: value.id,
    name: value.name,
    cnpj: value.cnpj,
    phone: value.phone,
    email: value.email,
    address: AddressData.fromDomain(value.address),
    registrationDate: value.registrationDate,
    lastUpdatedDate: value.lastUpdatedDate,
  );
  final int id;
  final String name;
  final String cnpj;
  final String? phone;
  final String? email;
  final AddressData address;
  final DateTime registrationDate;
  final DateTime? lastUpdatedDate;

  Map<String, dynamic> toJson() => _$CompanyDataToJson(this);

  Company toDomain() => Company(
    id: id,
    name: name,
    cnpj: cnpj,
    phone: phone,
    email: email,
    address: address.toDomain(),
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}
