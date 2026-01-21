import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/models/log_atividade.dart';
import 'package:system_loja/data/database/dao/log_dao.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

class LogRepository with LoggerClassMixin {
  final LogDao _logDao = AppInjection.instance.systemDatabase.logDao;

  /// Cria e registra um log de atividade
  Future<void> criarERegistrarLog({
    required TipoAcao tipoAcao,
    required String entidade,
    required int usuarioId,
    required String usuarioNome,
    String detalhes = '',
  }) async {
    final log = LogAtividade(
      id: 0,
      action: tipoAcao.name,
      entidade: entidade,
      usuarioId: usuarioId,
      usuarioNome: usuarioNome,
      detalhes: detalhes,
    );
    await registrarLog(log);
  }

  /// Limpa logs antigos (opcional - para manutenção)
  ///
  /// Remove logs mais antigos que a data especificada.
  Future<bool> limparLogsAntigos(DateTime dataLimite) async {
    logInfo('Logs antigos removidos até $dataLimite');
    return await _logDao.deleteLogsBefore(dataLimite);
  }

  /// Obtém logs de uma entidade específica
  Future<List<LogAtividade>> obterLogsPorEntidade(String entidade) async {
    return await _logDao.getWithFilter(entidade);
  }

  /// Obtém logs por período
  ///
  /// Inclui logs nos limites do período (dataInicio e dataFim são inclusos).
  Future<List<LogAtividade>> obterLogsPorPeriodo(
    DateTime dataInicio,
    DateTime dataFim,
  ) async {
    return await _logDao.getInDate(dataInicio, dataFim);
  }

  /// Obtém logs por tipo de ação
  Future<List<LogAtividade>> obterLogsPorTipoAcao(TipoAcao tipoAcao) async {
    return await _logDao.getWithAction(tipoAcao);
  }

  /// Obtém logs de um usuário específico
  Future<List<LogAtividade>> obterLogsPorUsuario(int usuarioId) async {
    return await _logDao.getWithUserId(usuarioId);
  }

  /// Obtém todos os logs
  Future<List<LogAtividade>> obterTodosLogs() async {
    return await _logDao.getAll();
  }

  /// Registra uma nova atividade no log
  ///
  /// Este método é usado para registrar todas as operações CRUD
  /// realizadas no sistema.
  Future<void> registrarLog(LogAtividade log) async {
    await _logDao.save(log);
    logInfo(
      'Log registrado: ${log.tipoAcao.name} - ${log.entidade} - ${log.usuarioNome}',
    );
  }
}
