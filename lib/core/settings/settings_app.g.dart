// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsApp _$SettingsAppFromJson(Map<String, dynamic> json) => SettingsApp(
  typeCache: $enumDecode(_$EnumTypeCacheEnumMap, json['typeCache']),
);

Map<String, dynamic> _$SettingsAppToJson(SettingsApp instance) =>
    <String, dynamic>{'typeCache': _$EnumTypeCacheEnumMap[instance.typeCache]!};

const _$EnumTypeCacheEnumMap = {
  EnumTypeCache.json: 'json',
  EnumTypeCache.sql: 'sql',
};
