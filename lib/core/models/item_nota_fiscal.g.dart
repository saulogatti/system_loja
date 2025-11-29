// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_nota_fiscal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemNotaFiscal _$ItemNotaFiscalFromJson(Map<String, dynamic> json) =>
    ItemNotaFiscal(
      produtoId: (json['produtoId'] as num).toInt(),
      produtoNome: json['produtoNome'] as String,
      produtoCodigo: json['produtoCodigo'] as String,
      quantidade: (json['quantidade'] as num).toInt(),
      precoUnitario: (json['precoUnitario'] as num).toDouble(),
    )..valorTotal = (json['valorTotal'] as num).toDouble();

Map<String, dynamic> _$ItemNotaFiscalToJson(ItemNotaFiscal instance) =>
    <String, dynamic>{
      'produtoId': instance.produtoId,
      'produtoNome': instance.produtoNome,
      'produtoCodigo': instance.produtoCodigo,
      'quantidade': instance.quantidade,
      'precoUnitario': instance.precoUnitario,
      'valorTotal': instance.valorTotal,
    };
