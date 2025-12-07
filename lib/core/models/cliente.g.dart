// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cliente _$ClienteFromJson(Map<String, dynamic> json) => Cliente.withDados(
  id: (json['id'] as num).toInt(),
  dadosCliente: DadosCliente.fromJson(
    json['dadosCliente'] as Map<String, dynamic>,
  ),
  dataCadastro: json['data_cadastro'] == null
      ? null
      : DateTime.parse(json['data_cadastro'] as String),
);

Map<String, dynamic> _$ClienteToJson(Cliente instance) => <String, dynamic>{
  'id': instance.id,
  'dadosCliente': instance.dadosCliente.toJson(),
  'data_cadastro': instance.dataCadastro.toIso8601String(),
};

DadosCliente _$DadosClienteFromJson(Map<String, dynamic> json) => DadosCliente(
  nome: json['nome'] as String,
  cpf: json['cpf'] as String,
  email: json['email'] as String,
  telefone: json['telefone'] as String,
  endereco: json['endereco'] as String,
);

Map<String, dynamic> _$DadosClienteToJson(DadosCliente instance) =>
    <String, dynamic>{
      'nome': instance.nome,
      'cpf': instance.cpf,
      'email': instance.email,
      'telefone': instance.telefone,
      'endereco': instance.endereco,
    };
