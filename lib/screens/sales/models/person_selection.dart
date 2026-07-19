import 'package:flutter/material.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/default/people_data.dart';

/// Representação unificada de cliente ou empresa para seleção na UI de vendas.
///
/// Permite um único dropdown em vez de dois separados, já que ambos
/// extendem [PersonDefault] e exibem nome + documento.
sealed class PersonSelection {

  const PersonSelection(this.person);
  final PersonDefault person;

  String get displayName => person.name;

  String get document;

  IconData get icon;
}

/// Seleção de cliente (pessoa física).
class CustomerSelection extends PersonSelection {
  CustomerSelection(super.customer);

  Customer get customer => person as Customer;

  @override
  String get document => customer.cpf;

  @override
  IconData get icon => Icons.person;
}

/// Seleção de empresa (pessoa jurídica).
class CompanySelection extends PersonSelection {
  CompanySelection(super.company);

  Company get company => person as Company;

  @override
  String get document => company.cnpj;

  @override
  IconData get icon => Icons.business;
}
