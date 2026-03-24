import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/default/people_data.dart';

/// Empresa (domínio). Serialização em `lib/data/models/company_data.dart`.
///
/// Representa uma empresa fornecedora com CNPJ e endereço.
/// Herda dados comuns de [PersonDefault] (nome, e-mail, telefone).
class Company extends PersonDefault {
  /// CNPJ da empresa. Utilizado como chave única de busca.
  final String cnpj;

  /// Endereço da empresa. Padrão: endereço vazio ([Address]).
  final Address address;

  Company({
    required super.name,
    required this.cnpj,
    super.id,
    super.phone,
    super.email,
    Address? address,
    super.registrationDate,
    super.lastUpdatedDate,
  }) : address = address ?? const Address();

  @override
  String toString() =>
      'Company(name: $name, cnpj: $cnpj, email: $email, phone: $phone, address: $address)';
}
