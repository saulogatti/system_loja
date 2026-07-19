import 'package:system_loja/core/models/default/default_object.dart';

/// Tipos de ação registrados no log de auditoria.
enum ActionType { criar, ler, atualizar, deletar }

/// Log de atividade (domínio). Serialização em `activity_log_data.dart`.
///
/// Registra ações dos usuários para fins de auditoria (criação, leitura,
/// atualização e exclusão de entidades do sistema).
class ActivityLog extends DefaultObject {
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

  /// Tipo de ação realizada (criar, ler, atualizar, deletar).
  final ActionType actionType;

  /// Nome da entidade afetada (ex.: Customer, Product, Invoice).
  final String entity;

  /// ID do usuário que realizou a ação.
  final int userId;

  /// Nome do usuário que realizou a ação.
  final String userName;

  /// Data e hora exata em que a ação foi realizada.
  final DateTime timestamp;

  /// Detalhes adicionais sobre a ação (opcional).
  final String details;

  /// Nome do tipo de ação como string (ex.: "criar", "deletar").
  String get action => actionType.name;

  @override
  String toString() =>
      'ActivityLog(actionType: $actionType, entity: $entity, userId: $userId, userName: $userName, timestamp: $timestamp, details: $details)';
}
