// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nota_fiscal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotaFiscal _$NotaFiscalFromJson(Map<String, dynamic> json) => NotaFiscal(
  id: (json['id'] as num).toInt(),
  numeroNota: json['numeroNota'] as String,
  clienteId: (json['clienteId'] as num).toInt(),
  clienteNome: json['clienteNome'] as String,
  clienteCpf: json['clienteCpf'] as String,
  itens: (json['itens'] as List<dynamic>)
      .map((e) => ItemNotaFiscal.fromJson(e as Map<String, dynamic>))
      .toList(),
  formaPagamento: json['formaPagamento'] as String,
  dataEmissao: json['dataEmissao'] == null
      ? null
      : DateTime.parse(json['dataEmissao'] as String),
);

Map<String, dynamic> _$NotaFiscalToJson(NotaFiscal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'numeroNota': instance.numeroNota,
      'clienteId': instance.clienteId,
      'clienteNome': instance.clienteNome,
      'clienteCpf': instance.clienteCpf,
      'itens': instance.itens,
      'formaPagamento': instance.formaPagamento,
      'dataEmissao': instance.dataEmissao.toIso8601String(),
    };
