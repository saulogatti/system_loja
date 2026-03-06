import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/document/cpf.dart';
import 'package:system_loja/core/models/person/person.dart';

part 'individual_entry.g.dart';

@JsonSerializable()
class IndividualEntry extends Individual {
  @override
  @CpfConverter()
  // ignore: overridden_fields
  Cpf? document;

  IndividualEntry({
    required super.name,
    required super.registrationDate,
    required super.lastUpdatedDate,
    super.id = -1,
    this.document,
    super.email,
    super.phone,
  }) : super(document: document);

  factory IndividualEntry.fromJson(Map<String, dynamic> json) => _$IndividualEntryFromJson(json);

  factory IndividualEntry.fromPerson(Individual person) {
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
