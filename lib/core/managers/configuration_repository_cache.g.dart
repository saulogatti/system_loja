// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_repository_cache.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationRepositoryCache _$ConfigurationRepositoryCacheFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ConfigurationRepositoryCache', json, ($checkedConvert) {
  final val = ConfigurationRepositoryCache(
    configuracao: $checkedConvert(
      'configuracao',
      (v) => AppSettings.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$ConfigurationRepositoryCacheToJson(
  ConfigurationRepositoryCache instance,
) => <String, dynamic>{'configuracao': instance.configuracao.toJson()};
