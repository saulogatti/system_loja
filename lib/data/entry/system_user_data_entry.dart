import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';
import 'package:system_loja/data/entry/individual_entry.dart';

part 'system_user_data_entry.g.dart';

@JsonSerializable()
class SystemUserDataEntry extends SystemUserData {
  SystemUserDataEntry({
    required super.systemKey,
    required super.description,
    required IndividualEntry person,
    super.id,
    super.registrationDate,
    super.lastUpdatedDate,
  }) : super(person: person);
  factory SystemUserDataEntry.fromJson(Map<String, dynamic> json) => _$SystemUserDataEntryFromJson(json);
  factory SystemUserDataEntry.fromSystemUserData(SystemUserData systemUserData) {
    return SystemUserDataEntry(
      systemKey: systemUserData.systemKey,
      description: systemUserData.description,
      person: IndividualEntry.fromPerson(systemUserData.person),
      id: systemUserData.id,
      registrationDate: systemUserData.registrationDate,
      lastUpdatedDate: systemUserData.lastUpdatedDate,
    );
  }
  @override
  IndividualEntry get person => super.person as IndividualEntry;
   

  Map<String, dynamic> toJson() => _$SystemUserDataEntryToJson(this);
}
