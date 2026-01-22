// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:system_loja/core/models/default/default_object.dart';

/// Dados de pessoa (usuario, cliente, fornecedor)
abstract class PeopleData extends DefaultObject {
  final String name;
  final String? email;

  PeopleData({
    required super.id,
    required this.name,
    this.email,
    super.registrationDate,
    super.lastUpdatedDate,
  });
}
