import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/document/cnpj.dart';
import 'package:system_loja/core/models/document/cpf.dart';

/// Conversor JSON de [Cpf] na camada de dados.
///
/// {@category dados}
/// {@subCategory Cadastros}
class CpfConverter extends JsonConverter<Cpf, String> {
  const CpfConverter();

  @override
  Cpf fromJson(String json) => Cpf(json);

  @override
  String toJson(Cpf value) => value.value;
}

/// Conversor JSON de [Cnpj] na camada de dados.
///
/// {@category dados}
/// {@subCategory Cadastros}
class CnpjConverter extends JsonConverter<Cnpj, String> {
  const CnpjConverter();

  @override
  Cnpj fromJson(String json) => Cnpj(json);

  @override
  String toJson(Cnpj value) => value.value;
}
