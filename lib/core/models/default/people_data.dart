import 'package:system_loja/core/models/company.dart' show Company;
import 'package:system_loja/core/models/customer.dart' show Customer;
import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/user.dart' show User;

/// Dados comuns a entidades que representam pessoas (usuário, cliente, fornecedor).
///
/// Extende [DefaultObject] adicionando nome, e-mail e telefone.
/// Subclasses concretas: [Customer], [Company], [User].
abstract class PersonDefault extends DefaultObject {
  PersonDefault({
    required this.name,
    this.email,
    this.phone,
    super.registrationDate,
    super.lastUpdatedDate,
    super.id,
  });

  /// Nome completo da pessoa ou razão social da empresa.
  final String name;

  /// Endereço de e-mail (opcional).
  final String? email;

  /// Número de telefone (opcional).
  final String? phone;
}
