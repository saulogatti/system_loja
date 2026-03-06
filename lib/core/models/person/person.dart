import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/document/cnpj.dart';
import 'package:system_loja/core/models/document/cpf.dart';
import 'package:system_loja/core/models/document/document.dart';

class DefaultObjectPerson extends Person<Cpf> {
  DefaultObjectPerson()
    : super(name: 'Default Person', document: Cpf.defaultObject());
}

class Individual extends Person<Cpf> {
  Individual({
    required super.name,
    required super.document,
    super.email,
    super.phone,
  });
}

class LegalEntity extends Person<Cnpj> {
  LegalEntity({
    required super.name,
    required super.document,
    super.email,
    super.phone,
  });
}

abstract class Person<D extends Document> extends DefaultObject {
  final String name;
  final String? email;
  final String? phone;
  final D? document;
  Person({
    required this.name,
    this.document,
    super.registrationDate,
    super.lastUpdatedDate,
    super.id,
    this.email,
    this.phone,
  });
  static DefaultObjectPerson defaultObject() => DefaultObjectPerson();

  static Individual individual({
    required String name,
    @CpfConverter() required Cpf document,
    String? email,
    String? phone,
  }) => Individual(name: name, document: document, email: email, phone: phone);

  static LegalEntity legalEntity({
    required String name,
    @CnpjConverter() required Cnpj document,
    String? email,
    String? phone,
  }) => LegalEntity(name: name, document: document, email: email, phone: phone);
}
