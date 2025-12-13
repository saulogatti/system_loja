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
  lastUpdatedDate: json['last_updated_date'] == null
      ? null
      : DateTime.parse(json['last_updated_date'] as String),
  registrationDate: json['registration_date'] == null
      ? null
      : DateTime.parse(json['registration_date'] as String),
);

Map<String, dynamic> _$ProdutoToJson(Produto instance) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'nome': instance.nome,
  'codigo': instance.codigo,
  'preco': instance.preco,
  'estoque': instance.estoque,
  'descricao': instance.descricao,
  'categoria': instance.categoria,
};
