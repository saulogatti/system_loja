// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_atividade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogAtividade _$LogAtividadeFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LogAtividade',
      json,
      ($checkedConvert) {
        final val = LogAtividade(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          tipoAcao: $checkedConvert(
            'tipo_acao',
            (v) => $enumDecodeNullable(_$TipoAcaoEnumMap, v) ?? TipoAcao.ler,
          ),
          entidade: $checkedConvert('entidade', (v) => v as String),
          entidadeId: $checkedConvert(
            'entidade_id',
            (v) => (v as num?)?.toInt(),
          ),
          usuarioId: $checkedConvert('usuario_id', (v) => (v as num).toInt()),
          usuarioNome: $checkedConvert('usuario_nome', (v) => v as String),
          dataHora: $checkedConvert(
            'data_hora',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          detalhes: $checkedConvert('detalhes', (v) => v as String? ?? ''),
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
        'tipoAcao': 'tipo_acao',
        'entidadeId': 'entidade_id',
        'usuarioId': 'usuario_id',
        'usuarioNome': 'usuario_nome',
        'dataHora': 'data_hora',
        'lastUpdatedDate': 'last_updated_date',
        'registrationDate': 'registration_date',
      },
    );

Map<String, dynamic> _$LogAtividadeToJson(LogAtividade instance) =>
    <String, dynamic>{
      'id': instance.id,
      'registration_date': instance.registrationDate.toIso8601String(),
      'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
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
