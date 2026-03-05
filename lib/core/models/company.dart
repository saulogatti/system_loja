import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/default/people_data.dart';

part 'company.g.dart';

/// Modelo de dados para Empresa
@JsonSerializable(explicitToJson: true)
class Company extends PeopleData {
  /// CNPJ da empresa (chave única)
  final String cnpj;

  final Address address;

  Company({
    required super.name, required this.cnpj, super.id,
    super.phone,
    super.email,
    Address? address,
    super.registrationDate,
    super.lastUpdatedDate,
  }) : address = address ?? Address();

  /// Cria um objeto a partir de JSON
  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
  @override
  String toString() => 'Company(name: $name, cnpj: $cnpj, email: $email, phone: $phone, address: $address)';
}
