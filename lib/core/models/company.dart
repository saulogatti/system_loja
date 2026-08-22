import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/default/people_data.dart';

/// Empresa fornecedora (domínio).
///
/// {@category modelos}
/// {@subCategory Cadastros}
///
/// Serialização em `lib/data/models/company_data.dart`.
/// Herda [PersonDefault] (nome, e-mail, telefone).
class Company extends PersonDefault {

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
  /// CNPJ da empresa. Utilizado como chave única de busca.
  final String cnpj;

  /// Endereço da empresa. Padrão: endereço vazio ([Address]).
  final Address address;

  @override
  String toString() =>
      'Company(name: $name, cnpj: $cnpj, email: $email, phone: $phone, address: $address)';
}
