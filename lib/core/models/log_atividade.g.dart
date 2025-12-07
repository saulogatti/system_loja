// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_atividade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogAtividade _$LogAtividadeFromJson(Map<String, dynamic> json) => LogAtividade(
  id: (json['id'] as num).toInt(),
  tipoAcao: $enumDecode(_$TipoAcaoEnumMap, json['tipo_acao']),
  entidade: json['entidade'] as String,
  entidadeId: (json['entidade_id'] as num?)?.toInt(),
  usuarioId: (json['usuario_id'] as num).toInt(),
  usuarioNome: json['usuario_nome'] as String,
  dataHora: json['data_hora'] == null
      ? null
      : DateTime.parse(json['data_hora'] as String),
  detalhes: json['detalhes'] as String? ?? '',
);

Map<String, dynamic> _$LogAtividadeToJson(LogAtividade instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tipo_acao': _$TipoAcaoEnumMap[instance.tipoAcao]!,
      'entidade': instance.entidade,
      'entidade_id': instance.entidadeId,
      'usuario_id': instance.usuarioId,
      'usuario_nome': instance.usuarioNome,
      'data_hora': instance.dataHora.toIso8601String(),
      'detalhes': instance.detalhes,
    };

const _$TipoAcaoEnumMap = {
  TipoAcao.criar: 'CRIAR',
  TipoAcao.ler: 'LER',
  TipoAcao.atualizar: 'ATUALIZAR',
  TipoAcao.deletar: 'DELETAR',
};
