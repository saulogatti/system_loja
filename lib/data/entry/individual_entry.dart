import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/document/cpf.dart';
import 'package:system_loja/core/models/person/person.dart';
import 'package:system_loja/data/converter/cpf_cnpj_json_converters.dart';

part 'individual_entry.g.dart';

/// DTO JSON para pessoa física (sem herdar [Person]).
@JsonSerializable(converters: [CpfConverter()])
class IndividualEntry {
  final String name;
  final Cpf document;
  final DateTime registrationDate;
  final DateTime lastUpdatedDate;
  final int id;
  final String? email;
  final String? phone;

  const IndividualEntry({
    required this.name,
    required this.document,
    required this.registrationDate,
    required this.lastUpdatedDate,
    this.id = -1,
    this.email,
    this.phone,
  });

  factory IndividualEntry.fromJson(Map<String, dynamic> json) =>
      _$IndividualEntryFromJson(json);

  factory IndividualEntry.fromPerson(Person<Cpf> person) {
    return IndividualEntry(
      name: person.name,
      document: person.document,
      email: person.email,
      phone: person.phone,
      id: person.id,
      registrationDate: person.registrationDate,
      lastUpdatedDate: person.lastUpdatedDate,
    );
  }

  Map<String, dynamic> toJson() => _$IndividualEntryToJson(this);

  /// Converte para modelo de domínio [Person].
  Person<Cpf> toPerson() => _IndividualPerson(
    name: name,
    document: document,
    email: email,
    phone: phone,
    id: id,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}

class _IndividualPerson extends Person<Cpf> {
  _IndividualPerson({
    required super.name,
    required super.document,
    required super.id,
    required super.registrationDate,
    required super.lastUpdatedDate,
    super.email,
    super.phone,
  });
}
