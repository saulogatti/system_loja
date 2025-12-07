import 'package:json_annotation/json_annotation.dart';

part 'settings_app.g.dart';

enum EnumTypeCache { json, sql }

@JsonSerializable()
class SettingsApp {
  final EnumTypeCache typeCache;
  SettingsApp({required this.typeCache});
  factory SettingsApp.fromJson(Map<String, dynamic> json) =>
      _$SettingsAppFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsAppToJson(this);
}
