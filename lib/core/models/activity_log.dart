// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'activity_log.g.dart';

/// Tipos de ação que podem ser registradas no log
enum ActionType {
  /// Criação de um novo registro
  @JsonValue('CRIAR')
  criar,

  /// Leitura/consulta de um registro
  @JsonValue('LER')
  ler,

  /// Atualização de um registro
  @JsonValue('ATUALIZAR')
  atualizar,

  /// Exclusão de um registro
  @JsonValue('DELETAR')
  deletar,
}

/// Modelo de dados para Log de Atividade
///
/// Registra as atividades realizadas no sistema para fins de auditoria.
/// Armazena informações sobre qual ação foi realizada, por qual usuário,
/// quando e detalhes adicionais sobre a operação.
@JsonSerializable(explicitToJson: true)
class ActivityLog extends DefaultObject {
  @JsonKey(name: 'tipo_acao')
  ActionType actionType;

  @JsonKey(name: 'entidade')
  final String entity;

  @JsonKey(name: 'usuario_id')
  final int userId;

  @JsonKey(name: 'usuario_nome')
  final String userName;

  @JsonKey(name: 'data_hora')
  final DateTime timestamp;

  final String details;

  ActivityLog({
    required super.id,
    required this.entity,
    required this.userId,
    required this.userName,
    DateTime? timestamp,
    this.details = '',
    super.lastUpdatedDate,
    super.registrationDate,
    String? action,
  }) : timestamp = timestamp ?? DateTime.now(),
       actionType = ActionType.values.firstWhere((e) => e.name == action, orElse: () => ActionType.ler);

  /// Cria um objeto a partir de JSON
  factory ActivityLog.fromJson(Map<String, dynamic> json) => _$ActivityLogFromJson(json);
  String get action => actionType.name;

  /// Converte o objeto para JSON
  Map<String, dynamic> toJson() => _$ActivityLogToJson(this);

  @override
  String toString() {
    return 'ActivityLog(actionType: $actionType, entity: $entity, userId: $userId, userName: $userName, timestamp: $timestamp, details: $details)';
  }
}
