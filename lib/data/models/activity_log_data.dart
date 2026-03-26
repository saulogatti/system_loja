import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/activity_log.dart';

part 'activity_log_data.g.dart';

/// JSON para [ActivityLog].
@JsonSerializable()
class ActivityLogData {
  @JsonKey(name: 'tipo_acao', fromJson: _actionFromJson, toJson: _actionToJson)
  final ActionType actionType;

  @JsonKey(name: 'entidade')
  final String entity;

  @JsonKey(name: 'usuario_id')
  final int userId;

  @JsonKey(name: 'usuario_nome')
  final String userName;

  @JsonKey(name: 'data_hora')
  final DateTime timestamp;

  final String details;

  final DateTime? registrationDate;
  final DateTime? lastUpdatedDate;

  const ActivityLogData({
    required this.actionType,
    required this.entity,
    required this.userId,
    required this.userName,
    required this.timestamp,
    this.details = '',
    this.registrationDate,
    this.lastUpdatedDate,
  });

  factory ActivityLogData.fromJson(Map<String, dynamic> json) => _$ActivityLogDataFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityLogDataToJson(this);

  factory ActivityLogData.fromDomain(ActivityLog value) => ActivityLogData(
    actionType: value.actionType,
    entity: value.entity,
    userId: value.userId,
    userName: value.userName,
    timestamp: value.timestamp,
    details: value.details,
    registrationDate: value.registrationDate,
    lastUpdatedDate: value.lastUpdatedDate,
  );

  ActivityLog toDomain() => ActivityLog(
    actionType: actionType,
    entity: entity,
    userId: userId,
    userName: userName,
    timestamp: timestamp,
    details: details,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );

  static ActionType _actionFromJson(Object? json) {
    final s = json as String;
    switch (s) {
      case 'CRIAR':
        return ActionType.criar;
      case 'LER':
        return ActionType.ler;
      case 'ATUALIZAR':
        return ActionType.atualizar;
      case 'DELETAR':
        return ActionType.deletar;
      default:
        try {
          return ActionType.values.byName(s.toLowerCase());
        } on ArgumentError {
          return ActionType.ler;
        }
    }
  }

  static String _actionToJson(ActionType action) => switch (action) {
    ActionType.criar => 'CRIAR',
    ActionType.ler => 'LER',
    ActionType.atualizar => 'ATUALIZAR',
    ActionType.deletar => 'DELETAR',
  };
}
