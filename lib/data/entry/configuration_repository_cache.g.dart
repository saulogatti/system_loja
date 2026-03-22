// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_repository_cache.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationRepositoryCache _$ConfigurationRepositoryCacheFromJson(
  Map<String, dynamic> json,
) => ConfigurationRepositoryCache(
  configuracao: AppSettings.fromJson(
    json['configuracao'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ConfigurationRepositoryCacheToJson(
  ConfigurationRepositoryCache instance,
) => <String, dynamic>{'configuracao': instance.configuracao};
