// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Produto _$ProdutoFromJson(Map<String, dynamic> json) => Produto(
  id: (json['id'] as num).toInt(),
  nome: json['nome'] as String,
  codigo: json['codigo'] as String,
  preco: (json['preco'] as num).toDouble(),
  estoque: (json['estoque'] as num).toInt(),
  descricao: json['descricao'] as String,
  categoria: json['categoria'] as String,
  dataCadastro: json['data_cadastro'] == null
      ? null
      : DateTime.parse(json['data_cadastro'] as String),
);

Map<String, dynamic> _$ProdutoToJson(Produto instance) => <String, dynamic>{
  'id': instance.id,
  'nome': instance.nome,
  'codigo': instance.codigo,
  'preco': instance.preco,
  'estoque': instance.estoque,
  'descricao': instance.descricao,
  'categoria': instance.categoria,
  'data_cadastro': instance.dataCadastro.toIso8601String(),
};
