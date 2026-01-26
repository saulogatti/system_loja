import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_errors/system_error.dart';

part 'system_error_model.g.dart';

@JsonSerializable()
class SystemErrorModel extends SystemError {
  String cacheKey;
  SystemErrorModel({
    required super.message,
    required super.code,
    required super.stackTrace,
    String? cacheKeyConstraint,
  }) : cacheKey = cacheKeyConstraint ?? '';
  

  factory SystemErrorModel.fromJson(Map<String, dynamic> json) =>
      _$SystemErrorModelFromJson(json);
  Map<String, dynamic> toJson() => _$SystemErrorModelToJson(this);
}
class StackTraceConverter implements JsonConverter<StackTrace, String> {
  const StackTraceConverter();

  @override
  StackTrace fromJson(String json) {
    return StackTrace.fromString(json);
  }
  @override
  String toJson(StackTrace object) {
    return object.toString();
  } 
}