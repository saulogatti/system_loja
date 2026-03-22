import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_errors/system_error.dart';

part 'system_error_model.g.dart';

class StackTraceJsonConverter implements JsonConverter<StackTrace, String> {
  const StackTraceJsonConverter();

  @override
  StackTrace fromJson(String json) {
    return StackTrace.fromString(json);
  }

  @override
  String toJson(StackTrace object) {
    return object.toString();
  }
}

/// DTO JSON para erros persistidos em cache (sem herdar [SystemError]).
@JsonSerializable()
class SystemErrorModel {
  final String message;
  final int code;
  @StackTraceJsonConverter()
  final StackTrace stackTrace;
  String cacheKey;

  SystemErrorModel({
    required this.message,
    required this.code,
    required this.stackTrace,
    String? cacheKeyConstraint,
  }) : cacheKey = cacheKeyConstraint ?? '';

  factory SystemErrorModel.fromJson(Map<String, dynamic> json) =>
      _$SystemErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$SystemErrorModelToJson(this);

  SystemError toDomain() =>
      SystemError(message: message, code: code, stackTrace: stackTrace);

  factory SystemErrorModel.fromDomain(SystemError error) => SystemErrorModel(
    message: error.message,
    code: error.code,
    stackTrace: error.stackTrace,
  );
}
