// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:system_loja/core/models/default/default_object.dart';

/// Tipos de ação registrados no log de auditoria.
enum ActionType {
  criar,
  ler,
  atualizar,
  deletar,
}

/// Log de atividade (domínio). Serialização em `activity_log_data.dart`.
class ActivityLog extends DefaultObject {
  final ActionType actionType;
  final String entity;
  final int userId;
  final String userName;
  final DateTime timestamp;
  final String details;

  ActivityLog({
    required this.actionType,
    required this.entity,
    required this.userId,
    required this.userName,
    DateTime? timestamp,
    this.details = '',
    super.lastUpdatedDate,
    super.registrationDate,
    super.id,
  }) : timestamp = timestamp ?? DateTime.now();

  String get action => actionType.name;

  @override
  String toString() {
    return 'ActivityLog(actionType: $actionType, entity: $entity, userId: $userId, userName: $userName, timestamp: $timestamp, details: $details)';
  }
}
