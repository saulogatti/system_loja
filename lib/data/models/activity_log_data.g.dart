// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityLogData _$ActivityLogDataFromJson(Map<String, dynamic> json) => ActivityLogData(
  actionType: ActivityLogData._actionFromJson(json['tipo_acao']),
  entity: json['entidade'] as String,
  userId: (json['usuario_id'] as num).toInt(),
  userName: json['usuario_nome'] as String,
  timestamp: DateTime.parse(json['data_hora'] as String),
  details: json['details'] as String? ?? '',
  registrationDate: json['registrationDate'] == null
      ? null
      : DateTime.parse(json['registrationDate'] as String),
  lastUpdatedDate: json['lastUpdatedDate'] == null ? null : DateTime.parse(json['lastUpdatedDate'] as String),
);

Map<String, dynamic> _$ActivityLogDataToJson(ActivityLogData instance) => <String, dynamic>{
  'tipo_acao': ActivityLogData._actionToJson(instance.actionType),
  'entidade': instance.entity,
  'usuario_id': instance.userId,
  'usuario_nome': instance.userName,
  'data_hora': instance.timestamp.toIso8601String(),
  'details': instance.details,
  'registrationDate': instance.registrationDate?.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate?.toIso8601String(),
};
