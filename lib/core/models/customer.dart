// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'customer.g.dart';

/// Modelo de dados para Cliente
@JsonSerializable(constructor: 'withData', explicitToJson: true)
class Customer extends DefaultObject {
  final CustomerInfo customerInfo;

  Customer({
    required super.id,
    required String name,
    required String cpf,
    required String email,
    required String phone,
    required String address, super.registrationDate, super.lastUpdatedDate,
  }) : customerInfo = CustomerInfo(
         name: name,
         cpf: cpf,
         email: email,
         phone: phone,
         address: address,
       );

  /// Cria um objeto a partir de JSON
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Customer.withData({
    required super.id,
    required this.customerInfo,
    super.registrationDate,
    super.lastUpdatedDate,
  });
  String get address => customerInfo.address;
  String get cpf => customerInfo.cpf;
  String get email => customerInfo.email;
  String get name => customerInfo.name;
  String get phone => customerInfo.phone;

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  String toString() =>
      'Customer(id: $id, customerInfo: $customerInfo, registrationDate: $registrationDate)';
}

@JsonSerializable()
class CustomerInfo {
  final String name;
  final String cpf;
  final String email;
  final String phone;
  final String address;

  CustomerInfo({
    required this.name,
    required this.cpf,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerInfoToJson(this);

  @override
  String toString() {
    return 'CustomerInfo(name: $name, cpf: $cpf, email: $email, phone: $phone, address: $address)';
  }
}
