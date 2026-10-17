// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file
// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_null_checks, unused_element, unnecessary_lambdas, inference_failure_on_collection_literal

part of 'system_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemErrorModel _$SystemErrorModelFromJson(Map<String, dynamic> json) =>
    SystemErrorModel(
      message: json['message'] as String,
      code: (json['code'] as num).toInt(),
      stackTrace: const StackTraceJsonConverter().fromJson(
        json['stackTrace'] as String,
      ),
    )..cacheKey = json['cacheKey'] as String;

Map<String, dynamic> _$SystemErrorModelToJson(SystemErrorModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'stackTrace': const StackTraceJsonConverter().toJson(instance.stackTrace),
      'cacheKey': instance.cacheKey,
    };
