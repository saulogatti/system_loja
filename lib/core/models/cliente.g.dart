// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cliente _$ClienteFromJson(Map<String, dynamic> json) => Cliente(
  id: (json['id'] as num).toInt(),
  nome: json['nome'] as String,
  cpf: json['cpf'] as String,
  email: json['email'] as String,
  telefone: json['telefone'] as String,
  endereco: json['endereco'] as String,
  dataCadastro: json['data_cadastro'] == null
      ? null
      : DateTime.parse(json['data_cadastro'] as String),
);

Map<String, dynamic> _$ClienteToJson(Cliente instance) => <String, dynamic>{
  'id': instance.id,
  'nome': instance.nome,
  'cpf': instance.cpf,
  'email': instance.email,
  'telefone': instance.telefone,
  'endereco': instance.endereco,
  'data_cadastro': instance.dataCadastro.toIso8601String(),
};
