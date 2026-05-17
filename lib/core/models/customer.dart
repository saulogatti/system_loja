import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/default/people_data.dart';

/// Cliente (domínio). Serialização em `lib/data/models/customer_data.dart`.
///
/// Representa um cliente pessoa física com CPF e endereço.
/// Herda dados comuns de [PersonDefault] (nome, e-mail, telefone).
class Customer extends PersonDefault {
  /// CPF do cliente. Utilizado como chave de busca única.
  final String cpf;

  /// Endereço do cliente. Padrão: endereço vazio ([Address]).
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
