import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/domain/repository/configuration_repository.dart';
import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/data/cache/models/cacheable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'configuration_repository_cache.g.dart';
@JsonSerializable()
class ConfigurationRepositoryCache extends Cacheable {
  final AppSettings configuracao;
  ConfigurationRepositoryCache({required this.configuracao});
  @override
  String get cacheKey => keyConfigurationRepositoryCache;
  factory ConfigurationRepositoryCache.fromJson(Map<String, dynamic> json) => _$ConfigurationRepositoryCacheFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ConfigurationRepositoryCacheToJson(this);
}
