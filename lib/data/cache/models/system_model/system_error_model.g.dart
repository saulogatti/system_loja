// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemErrorModel _$SystemErrorModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SystemErrorModel', json, ($checkedConvert) {
      final val = SystemErrorModel(
        message: $checkedConvert('message', (v) => v as String),
        code: $checkedConvert('code', (v) => (v as num).toInt()),
        stackTrace: $checkedConvert(
          'stackTrace',
          (v) => const StackTraceConverter().fromJson(v as String),
        ),
      );
      $checkedConvert('cacheKey', (v) => val.cacheKey = v as String);
      return val;
    });

Map<String, dynamic> _$SystemErrorModelToJson(SystemErrorModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'stackTrace': const StackTraceConverter().toJson(instance.stackTrace),
      'cacheKey': instance.cacheKey,
    };
