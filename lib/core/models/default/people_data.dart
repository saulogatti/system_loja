// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:system_loja/core/models/default/default_object.dart';

/// Dados comuns a entidades que representam pessoas (usuário, cliente, fornecedor).
///
/// Extende [DefaultObject] adicionando nome, e-mail e telefone.
/// Subclasses concretas: [Customer], [Company], [User].
abstract class PersonDefault extends DefaultObject {
  /// Nome completo da pessoa ou razão social da empresa.
  final String name;

  /// Endereço de e-mail (opcional).
  final String? email;

  /// Número de telefone (opcional).
  final String? phone;

  PersonDefault({
    required this.name,
    this.email,
    this.phone,
    super.registrationDate,
    super.lastUpdatedDate,
    super.id,
  });
}
