import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/system_errors/system_error.dart';

part 'system_error_model.g.dart';

/// Conversor JSON de [StackTrace] para persistência em arquivo.
///
/// {@category dados}
/// {@subCategory Sistema}
class StackTraceJsonConverter implements JsonConverter<StackTrace, String> {
  const StackTraceJsonConverter();

  @override
  StackTrace fromJson(String json) => StackTrace.fromString(json);

  @override
  String toJson(StackTrace object) => object.toString();
}

/// DTO JSON de erro persistido em cache de arquivo, sem herdar [SystemError].
///
/// {@category dados}
/// {@subCategory Sistema}
///
/// Não substitui o Drift; serve só para serializar o erro em disco.
@JsonSerializable()
class SystemErrorModel {

  SystemErrorModel({
    required this.message,
    required this.code,
    required this.stackTrace,
    String? cacheKeyConstraint,
  }) : cacheKey = cacheKeyConstraint ?? '';

  factory SystemErrorModel.fromJson(Map<String, dynamic> json) =>
      _$SystemErrorModelFromJson(json);

  factory SystemErrorModel.fromDomain(SystemError error) => SystemErrorModel(
    message: error.message,
    code: error.code,
    stackTrace: error.stackTrace,
  );
  final String message;
  final int code;
  @StackTraceJsonConverter()
  final StackTrace stackTrace;
  String cacheKey;

  Map<String, dynamic> toJson() => _$SystemErrorModelToJson(this);

  /// Converte o DTO para o modelo de domínio [SystemError].
  SystemError toDomain() =>
      SystemError(message: message, code: code, stackTrace: stackTrace);
}
