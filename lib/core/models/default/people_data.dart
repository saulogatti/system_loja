// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:system_loja/core/models/default/default_object.dart';

/// Dados de pessoa (usuario, cliente, fornecedor) PersonDefault ou DefaultPerson? Usar o nome PersonDefault
abstract class PersonDefault extends DefaultObject {
  final String name;
  final String? email;
  final String? phone;
  PersonDefault({
    required super.id,
    required this.name,
    this.email,
    this.phone,
    super.registrationDate,
    super.lastUpdatedDate,
  });
}
  