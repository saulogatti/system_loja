// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityLog _$ActivityLogFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ActivityLog',
  json,
  ($checkedConvert) {
    final val = ActivityLog(
      id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
      entity: $checkedConvert('entidade', (v) => v as String),
      userId: $checkedConvert('usuario_id', (v) => (v as num).toInt()),
      userName: $checkedConvert('usuario_nome', (v) => v as String),
      timestamp: $checkedConvert(
        'data_hora',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      details: $checkedConvert('details', (v) => v as String? ?? ''),
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
      (v) => val.actionType = $enumDecode(_$ActionTypeEnumMap, v),
    );
    return val;
  },
  fieldKeyMap: const {
    'entity': 'entidade',
    'userId': 'usuario_id',
    'userName': 'usuario_nome',
    'timestamp': 'data_hora',
    'lastUpdatedDate': 'last_updated_date',
    'registrationDate': 'registration_date',
    'actionType': 'tipo_acao',
  },
);

Map<String, dynamic> _$ActivityLogToJson(ActivityLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'registration_date': instance.registrationDate.toIso8601String(),
      'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
      'tipo_acao': _$ActionTypeEnumMap[instance.actionType]!,
      'entidade': instance.entity,
      'usuario_id': instance.userId,
      'usuario_nome': instance.userName,
      'data_hora': instance.timestamp.toIso8601String(),
      'details': instance.details,
      'action': instance.action,
    };

const _$ActionTypeEnumMap = {
  ActionType.criar: 'CRIAR',
  ActionType.ler: 'LER',
  ActionType.atualizar: 'ATUALIZAR',
  ActionType.deletar: 'DELETAR',
};
