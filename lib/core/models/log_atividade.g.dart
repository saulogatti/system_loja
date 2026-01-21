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
          entidade: $checkedConvert('entidade', (v) => v as String),
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
          action: $checkedConvert('action', (v) => v as String?),
        );
        $checkedConvert(
          'tipo_acao',
          (v) => val.tipoAcao = $enumDecode(_$TipoAcaoEnumMap, v),
        );
        return val;
      },
      fieldKeyMap: const {
        'usuarioId': 'usuario_id',
        'usuarioNome': 'usuario_nome',
        'dataHora': 'data_hora',
        'lastUpdatedDate': 'last_updated_date',
        'registrationDate': 'registration_date',
        'tipoAcao': 'tipo_acao',
      },
    );

Map<String, dynamic> _$LogAtividadeToJson(LogAtividade instance) =>
    <String, dynamic>{
      'id': instance.id,
      'registration_date': instance.registrationDate.toIso8601String(),
      'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
      'tipo_acao': _$TipoAcaoEnumMap[instance.tipoAcao]!,
      'entidade': instance.entidade,
      'usuario_id': instance.usuarioId,
      'usuario_nome': instance.usuarioNome,
      'data_hora': instance.dataHora.toIso8601String(),
      'detalhes': instance.detalhes,
      'action': instance.action,
    };

const _$TipoAcaoEnumMap = {
  TipoAcao.criar: 'CRIAR',
  TipoAcao.ler: 'LER',
  TipoAcao.atualizar: 'ATUALIZAR',
  TipoAcao.deletar: 'DELETAR',
};
