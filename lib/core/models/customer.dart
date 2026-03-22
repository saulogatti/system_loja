import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/default/people_data.dart';

/// Cliente (domínio). Serialização em `lib/data/models/customer_data.dart`.
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
  }) : address = address ?? const Address();

  @override
  String toString() =>
      'Customer(name: $name, cpf: $cpf, email: $email, phone: $phone, address: $address)';
}
