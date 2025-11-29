// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_nota_fiscal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemNotaFiscal _$ItemNotaFiscalFromJson(Map<String, dynamic> json) =>
    ItemNotaFiscal(
      produtoId: (json['produto_id'] as num).toInt(),
      produtoNome: json['produto_nome'] as String,
      produtoCodigo: json['produto_codigo'] as String,
      quantidade: (json['quantidade'] as num).toInt(),
      precoUnitario: (json['preco_unitario'] as num).toDouble(),
    );

Map<String, dynamic> _$ItemNotaFiscalToJson(ItemNotaFiscal instance) =>
    <String, dynamic>{
      'produto_id': instance.produtoId,
      'produto_nome': instance.produtoNome,
      'produto_codigo': instance.produtoCodigo,
      'quantidade': instance.quantidade,
      'preco_unitario': instance.precoUnitario,
    };
