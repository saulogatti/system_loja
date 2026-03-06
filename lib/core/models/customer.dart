import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/default/people_data.dart';

part 'customer.g.dart';

/// Modelo de dados para Cliente
@JsonSerializable(explicitToJson: true)
class Customer extends PersonDefault {
  final String cpf;

  final Address address;
  Customer({
    required super.name,
    required this.cpf,
    super.id,
    super.email,
    super.phone,
    Address? address,

    super.registrationDate,
    super.lastUpdatedDate,
  }) : address = address ?? Address();

  /// Cria um objeto a partir de JSON
  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  String toString() => 'Customer(name: $name, cpf: $cpf, email: $email, phone: $phone, address: $address)';
}
