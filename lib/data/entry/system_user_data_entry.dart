import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';

part 'system_user_data_entry.g.dart';

@JsonSerializable()
class SystemUserDataEntry extends SystemUserData {
  SystemUserDataEntry({
    required super.name,
    required super.email,
    required super.phone,
    required super.systemKey,
    required super.description,
    super.id,
    super.registrationDate,
    super.lastUpdatedDate,
  });
  factory SystemUserDataEntry.fromJson(Map<String, dynamic> json) =>
      _$SystemUserDataEntryFromJson(json);
  factory SystemUserDataEntry.fromSystemUserData(
    SystemUserData systemUserData,
  ) {
    return SystemUserDataEntry(
      name: systemUserData.name,
      email: systemUserData.email,
      phone: systemUserData.phone,
      systemKey: systemUserData.systemKey,
      description: systemUserData.description,
      id: systemUserData.id,
      registrationDate: systemUserData.registrationDate,
      lastUpdatedDate: systemUserData.lastUpdatedDate,
    );
  }
  Map<String, dynamic> toJson() => _$SystemUserDataEntryToJson(this);
}
