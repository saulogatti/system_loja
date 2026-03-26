import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';

part 'system_user_data_entry.g.dart';

/// DTO JSON para [SystemUserData] (sem herdar domínio).
@JsonSerializable()
class SystemUserDataEntry {
  final String name;
  final String? email;
  final String? phone;
  final String systemKey;
  final String description;
  final int id;
  final DateTime registrationDate;
  final DateTime lastUpdatedDate;

  const SystemUserDataEntry({
    required this.name,
    required this.systemKey,
    required this.description,
    required this.registrationDate,
    required this.lastUpdatedDate,
    this.email,
    this.phone,
    this.id = -1,
  });

  factory SystemUserDataEntry.fromJson(Map<String, dynamic> json) => _$SystemUserDataEntryFromJson(json);

  Map<String, dynamic> toJson() => _$SystemUserDataEntryToJson(this);

  factory SystemUserDataEntry.fromSystemUserData(SystemUserData systemUserData) {
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

  SystemUserData toDomain() => SystemUserData(
    name: name,
    email: email ?? '',
    phone: phone ?? '',
    systemKey: systemKey,
    description: description,
    id: id,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}
