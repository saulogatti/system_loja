// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_cache_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationCacheEntry _$ConfigurationCacheEntryFromJson(
  Map<String, dynamic> json,
) => ConfigurationCacheEntry(
  configuracao: AppSettingsEntry.fromJson(
    json['configuracao'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ConfigurationCacheEntryToJson(
  ConfigurationCacheEntry instance,
) => <String, dynamic>{'configuracao': instance.configuracao};
