import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/person/person.dart';

part 'person_entry.g.dart';

@JsonSerializable()
class PersonEntry extends Person {
  PersonEntry({
    required super.name,
    required super.document,
    super.email,
    super.phone,
    super.id,
    super.registrationDate,
    super.lastUpdatedDate,
  });
  factory PersonEntry.fromJson(Map<String, dynamic> json) => _$PersonEntryFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PersonEntryToJson(this);
}
