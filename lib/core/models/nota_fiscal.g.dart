// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nota_fiscal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotaFiscal _$NotaFiscalFromJson(Map<String, dynamic> json) => NotaFiscal(
  id: (json['id'] as num).toInt(),
  numeroNota: json['numero_nota'] as String,
  clienteId: (json['cliente_id'] as num).toInt(),
  clienteNome: json['cliente_nome'] as String,
  clienteCpf: json['cliente_cpf'] as String,
  itens: (json['itens'] as List<dynamic>)
      .map((e) => ItemNotaFiscal.fromJson(e as Map<String, dynamic>))
      .toList(),
  formaPagamento: json['forma_pagamento'] as String,
  dataEmissao: json['data_emissao'] == null
      ? null
      : DateTime.parse(json['data_emissao'] as String),
);

Map<String, dynamic> _$NotaFiscalToJson(NotaFiscal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'numero_nota': instance.numeroNota,
      'cliente_id': instance.clienteId,
      'cliente_nome': instance.clienteNome,
      'cliente_cpf': instance.clienteCpf,
      'itens': instance.itens.map((e) => e.toJson()).toList(),
      'forma_pagamento': instance.formaPagamento,
      'data_emissao': instance.dataEmissao.toIso8601String(),
    };
