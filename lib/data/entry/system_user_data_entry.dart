import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/person/person.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';
import 'package:system_loja/data/entry/person_entry.dart';

part 'system_user_data_entry.g.dart';

@JsonSerializable()
class SystemUserDataEntry extends SystemUserData {
  SystemUserDataEntry({
    required super.systemKey,
    required super.description,
    PersonEntry? person,
    super.id,
    super.registrationDate,
    super.lastUpdatedDate,
  }) : super(person: person ?? Person.defaultObject());
  factory SystemUserDataEntry.fromJson(Map<String, dynamic> json) => _$SystemUserDataEntryFromJson(json);
  Map<String, dynamic> toJson() => _$SystemUserDataEntryToJson(this);
}
