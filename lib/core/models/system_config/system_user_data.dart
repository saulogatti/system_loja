import 'package:drift/drift.dart' as drift;
import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'system_user_data.g.dart';

@JsonSerializable(explicitToJson: true)
class SystemUserData extends DefaultObject {
  static drift.JsonTypeConverter2<SystemUserData, String, Object?> converter = drift.TypeConverter.json2(
    fromJson: (json) => SystemUserData.fromJson(json as Map<String, dynamic>),
    toJson: (systemUserData) => systemUserData.toJson(),
  );
  final String name;
  final String email;
  final String systemKey;
  SystemUserData({
    required this.name,
    required this.email,
    required this.systemKey,
    super.id,
    super.registrationDate,
    super.lastUpdatedDate,
  });
  factory SystemUserData.fromJson(Map<String, dynamic> json) => _$SystemUserDataFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SystemUserDataToJson(this);
}
