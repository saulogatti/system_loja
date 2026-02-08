import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'company.g.dart';

/// Modelo de dados para Empresa
@JsonSerializable(explicitToJson: true)
class Company extends DefaultObject {
  /// Razão social da empresa
  final String corporateName;

  /// CNPJ da empresa (chave única)
  final String cnpj;

  /// Email da empresa
  final String? email;
  final Address address;

  Company({
    required super.id,
    required this.corporateName,
    required this.cnpj,
    this.email,
    Address? address,
    super.registrationDate,
    super.lastUpdatedDate,
  }) : address = address ?? Address();

  /// Cria um objeto a partir de JSON
  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
  @override
  String toString() =>
      'Company(corporateName: $corporateName, cnpj: $cnpj, email: $email, address: $address)';
}
