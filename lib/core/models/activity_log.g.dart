// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityLog _$ActivityLogFromJson(Map<String, dynamic> json) => ActivityLog(
  entity: json['entidade'] as String,
  userId: (json['usuario_id'] as num).toInt(),
  userName: json['usuario_nome'] as String,
  timestamp: json['data_hora'] == null
      ? null
      : DateTime.parse(json['data_hora'] as String),
  details: json['details'] as String? ?? '',
  lastUpdatedDate: json['lastUpdatedDate'] == null
      ? null
      : DateTime.parse(json['lastUpdatedDate'] as String),
  registrationDate: json['registrationDate'] == null
      ? null
      : DateTime.parse(json['registrationDate'] as String),
  action: json['action'] as String?,
)..actionType = $enumDecode(_$ActionTypeEnumMap, json['tipo_acao']);

Map<String, dynamic> _$ActivityLogToJson(ActivityLog instance) =>
    <String, dynamic>{
      'registrationDate': instance.registrationDate.toIso8601String(),
      'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
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
