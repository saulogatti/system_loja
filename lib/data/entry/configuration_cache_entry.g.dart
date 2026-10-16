// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file
// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_null_checks, unused_element, unnecessary_lambdas, inference_failure_on_collection_literal

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
