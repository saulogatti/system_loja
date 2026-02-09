import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/default/people_data.dart';

part 'customer.g.dart';

/// Modelo de dados para Cliente
@JsonSerializable(explicitToJson: true)
class Customer extends PeopleData {
  final String cpf;
  final String? phone;
  final Address address;
  Customer({
    required super.id,
    required super.name,
    super.email,
    required this.cpf,
    this.phone,
    Address? address,

    super.registrationDate,
    super.lastUpdatedDate,
  }) : address = address ?? Address();

  /// Cria um objeto a partir de JSON
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  String toString() => 'Customer(cpf: $cpf, phone: $phone, address: $address)';
}
