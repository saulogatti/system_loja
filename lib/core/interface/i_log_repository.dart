import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/core/utils/result_status.dart';
import 'package:system_loja/data/database/system_database.dart';

/// Contrato de auditoria de ações do sistema.
///
/// {@category contratos}
/// {@subCategory Sistema}
///
/// Persistência de [ActivityLog] no [SystemDatabase] (Drift). Filtros por
/// usuário, tipo de ação, entidade ou período. Erros voltam como
/// [ResultStatus.error].
///
/// Resolver com `appInjection.get<ILogRepository>()`.
///
/// ```dart
/// final repository = appInjection.get<ILogRepository>();
///
/// // Registrar uma ação
/// await repository.createAndLogEntry(
///   logActionType: ActionType.criar,
///   entityName: 'Customer',
///   userId: 1,
///   username: 'admin',
///   logDetails: 'Cliente João Silva cadastrado',
/// );
///
/// // Consultar logs de um período
/// final resultado = await repository.fetchLogsByPeriod(
///   DateTime(2024, 1, 1),
///   DateTime(2024, 12, 31),
/// );
/// ```
///
/// Veja também:
/// - [ActivityLog] - modelo de domínio de log de atividade
/// - [ActionType] - enum com tipos de ações registradas
/// - [ResultStatus] - tipo de retorno para operações
abstract interface class ILogRepository {
  /// Remove logs antigos anteriores à data de corte especificada.
  ///
  /// Útil para manutenção periódica e controle de espaço em disco.
  ///
  /// Parâmetros:
  /// - [cutoffDate]: Data limite (logs anteriores serão removidos)
  ///
  /// Retorna:
  /// - [ResultStatus] com true se removidos com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> clearOldLogs(DateTime cutoffDate);

  /// Cria e registra uma nova entrada de log de forma simplificada.
  ///
  /// Este método é um atalho para criar e salvar logs em uma única operação.
  ///
  /// Parâmetros:
  /// - [logActionType]: Tipo da ação realizada (create, update, delete, etc.)
  /// - [entityName]: Nome da entidade afetada (Customer, Product, etc.)
  /// - [userId]: ID do usuário que realizou a ação
  /// - [username]: Nome do usuário para facilitar consultas
  /// - [logDetails]: Detalhes adicionais da ação (opcional)
  ///
  /// Retorna:
  /// - [ResultStatus] com void em caso de sucesso ou mensagem de erro
  Future<ResultStatus<void, String>> createAndLogEntry({
    required ActionType logActionType,
    required String entityName,
    required int userId,
    required String username,
    String logDetails = '',
  });

  /// Retorna todos os logs de atividade do sistema.
  ///
  /// **ATENÇÃO**: Esta operação pode retornar grande volume de dados.
  /// Considere usar filtros específicos quando possível.
  ///
  /// Retorna:
  /// - [ResultStatus] com lista de logs ou mensagem de erro
  Future<ResultStatus<List<ActivityLog>, String>> fetchAllLogs();

  /// Retorna logs filtrados por tipo de ação.
  ///
  /// Útil para auditar operações específicas como exclusões ou criações.
  ///
  /// Parâmetros:
  /// - [actionType]: Tipo de ação a ser filtrada (create, update, delete, etc.)
  ///
  /// Retorna:
  /// - [ResultStatus] com lista de logs ou mensagem de erro
  Future<ResultStatus<List<ActivityLog>, String>> fetchLogsByActionType(
    ActionType actionType,
  );

  /// Retorna logs filtrados por entidade.
  ///
  /// Útil para ver histórico de uma entidade específica (Customer, Product, etc.).
  ///
  /// Parâmetros:
  /// - [entity]: Nome da entidade a ser filtrada
  ///
  /// Retorna:
  /// - [ResultStatus] com lista de logs ou mensagem de erro
  Future<ResultStatus<List<ActivityLog>, String>> fetchLogsByEntity(
    String entity,
  );

  /// Retorna logs de um período específico.
  ///
  /// Útil para relatórios e análise de atividades em intervalo de tempo.
  ///
  /// Parâmetros:
  /// - [startDate]: Data inicial do período (inclusiva)
  /// - [endDate]: Data final do período (inclusiva)
  ///
  /// Retorna:
  /// - [ResultStatus] com lista de logs ou mensagem de erro
  Future<ResultStatus<List<ActivityLog>, String>> fetchLogsByPeriod(
    DateTime startDate,
    DateTime endDate,
  );

  /// Retorna logs de um usuário específico.
  ///
  /// Útil para auditar ações de um usuário em particular.
  ///
  /// Parâmetros:
  /// - [userId]: ID do usuário
  ///
  /// Retorna:
  /// - [ResultStatus] com lista de logs ou mensagem de erro
  Future<ResultStatus<List<ActivityLog>, String>> fetchLogsByUser(int userId);

  /// Salva um log de atividade diretamente.
  ///
  /// Para casos onde o log já foi construído externamente.
  /// Considere usar [createAndLogEntry] para criação simplificada.
  ///
  /// Parâmetros:
  /// - [log]: Objeto ActivityLog completo a ser salvo
  ///
  /// Retorna:
  /// - [ResultStatus] com void em caso de sucesso ou mensagem de erro
  Future<ResultStatus<void, String>> saveActivityLog(ActivityLog log);
}
