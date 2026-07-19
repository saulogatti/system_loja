import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/constants/cache_keys.dart';
import 'package:system_loja/data/cache/models/cacheable.dart';
import 'package:system_loja/data/entry/app_settings_entry.dart';

part 'configuration_cache_entry.g.dart';

@JsonSerializable()
class ConfigurationCacheEntry extends Cacheable {
  ConfigurationCacheEntry({required this.configuracao});
  factory ConfigurationCacheEntry.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationCacheEntryFromJson(json);
  final AppSettingsEntry configuracao;
  @override
  String get cacheKey => keyConfigurationRepositoryCache;
  @override
  Map<String, dynamic> toJson() => _$ConfigurationCacheEntryToJson(this);
}
