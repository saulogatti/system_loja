import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/document/cnpj.dart';
import 'package:system_loja/core/models/document/cpf.dart';

/// Conversor JSON para [Cpf] (camada de dados).
class CpfConverter extends JsonConverter<Cpf, String> {
  const CpfConverter();

  @override
  Cpf fromJson(String json) => Cpf(json);

  @override
  String toJson(Cpf value) => value.value;
}

/// Conversor JSON para [Cnpj] (camada de dados).
class CnpjConverter extends JsonConverter<Cnpj, String> {
  const CnpjConverter();

  @override
  Cnpj fromJson(String json) => Cnpj(json);

  @override
  String toJson(Cnpj value) => value.value;
}
