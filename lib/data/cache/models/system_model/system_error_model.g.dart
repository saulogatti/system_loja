// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemErrorModel _$SystemErrorModelFromJson(Map<String, dynamic> json) =>
    SystemErrorModel(
      message: json['message'] as String,
      code: (json['code'] as num).toInt(),
      stackTrace: const StackTraceConverter().fromJson(
        json['stackTrace'] as String,
      ),
    )..cacheKey = json['cacheKey'] as String;

Map<String, dynamic> _$SystemErrorModelToJson(SystemErrorModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'stackTrace': const StackTraceConverter().toJson(instance.stackTrace),
      'cacheKey': instance.cacheKey,
    };
