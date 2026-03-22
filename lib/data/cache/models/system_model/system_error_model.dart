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

@JsonSerializable()
class SystemErrorModel extends SystemError {
  @override
  @StackTraceJsonConverter()
  // ignore: overridden_fields
  final StackTrace stackTrace;
  String cacheKey;
  SystemErrorModel({
    required super.message,
    required super.code,
    required this.stackTrace,
    String? cacheKeyConstraint,
  }) : cacheKey = cacheKeyConstraint ?? '',
       super(stackTrace: stackTrace);

  factory SystemErrorModel.fromJson(Map<String, dynamic> json) =>
      _$SystemErrorModelFromJson(json);
  Map<String, dynamic> toJson() => _$SystemErrorModelToJson(this);
}
