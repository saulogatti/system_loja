import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/document/cpf.dart';
import 'package:system_loja/core/models/person/person.dart';

part 'individual_entry.g.dart';

@JsonSerializable(converters: [CpfConverter()])
class IndividualEntry extends Person<Cpf> {
  IndividualEntry({
    required super.name,
    required super.document,
    required super.registrationDate,
    required super.lastUpdatedDate,
    super.id,
    super.email,
    super.phone,
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
}
