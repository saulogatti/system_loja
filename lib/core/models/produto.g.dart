// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Produto _$ProdutoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Produto',
  json,
  ($checkedConvert) {
    final val = Produto(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      nome: $checkedConvert('nome', (v) => v as String),
      codigo: $checkedConvert('codigo', (v) => v as String),
      preco: $checkedConvert('preco', (v) => (v as num).toDouble()),
      estoque: $checkedConvert('estoque', (v) => (v as num).toInt()),
      descricao: $checkedConvert('descricao', (v) => v as String),
      categoria: $checkedConvert('categoria', (v) => v as String),
      lastUpdatedDate: $checkedConvert(
        'last_updated_date',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      registrationDate: $checkedConvert(
        'registration_date',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'lastUpdatedDate': 'last_updated_date',
    'registrationDate': 'registration_date',
  },
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
