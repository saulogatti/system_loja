// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityLog _$ActivityLogFromJson(Map<String, dynamic> json) => ActivityLog(
  id: (json['id'] as num?)?.toInt(),
  entity: json['entidade'] as String,
  userId: (json['usuario_id'] as num).toInt(),
  userName: json['usuario_nome'] as String,
  timestamp: json['data_hora'] == null
      ? null
      : DateTime.parse(json['data_hora'] as String),
  details: json['details'] as String? ?? '',
  lastUpdatedDate: json['last_updated_date'] == null
      ? null
      : DateTime.parse(json['last_updated_date'] as String),
  registrationDate: json['registration_date'] == null
      ? null
      : DateTime.parse(json['registration_date'] as String),
  action: json['action'] as String?,
)..actionType = $enumDecode(_$ActionTypeEnumMap, json['tipo_acao']);

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
