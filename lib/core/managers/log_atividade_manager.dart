import 'dart:convert';
import 'dart:io';

import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:synchronized/synchronized.dart';

import '../models/log_atividade.dart';

/// Gerenciador de Logs de Atividade
///
/// Registra todas as atividades realizadas no sistema para fins de auditoria.
/// Utiliza um mecanismo de sincronização para evitar condições de corrida.
class LogAtividadeManager with LoggerClassMixin {
  /// Lock estático por arquivo para serializar o acesso entre múltiplas instâncias
  static final Map<String, Lock> _fileLocks = {};
  final String dataFile;

  List<LogAtividade> logs = [];

  LogAtividadeManager({this.dataFile = 'data/logs_atividade.json'}) {
    _carregarDados();
  }

  /// Obtém todos os logs
  List<LogAtividade> obterTodosLogs() {
    return logs;
  }

  /// Obtém logs de um usuário específico
  List<LogAtividade> obterLogsPorUsuario(int usuarioId) {
    return logs.where((log) => log.usuarioId == usuarioId).toList();
  }

  /// Obtém logs de uma entidade específica
  List<LogAtividade> obterLogsPorEntidade(String entidade, {int? entidadeId}) {
    if (entidadeId != null) {
      return logs.where((log) => log.entidade == entidade && log.entidadeId == entidadeId).toList();
    }
    return logs.where((log) => log.entidade == entidade).toList();
  }

  /// Obtém logs por tipo de ação
  List<LogAtividade> obterLogsPorTipoAcao(TipoAcao tipoAcao) {
    return logs.where((log) => log.tipoAcao == tipoAcao).toList();
  }

  /// Obtém logs por período
  ///
  /// Inclui logs nos limites do período (dataInicio e dataFim são inclusos).
  List<LogAtividade> obterLogsPorPeriodo(DateTime dataInicio, DateTime dataFim) {
    return logs.where((log) {
      return (log.dataHora.isAtSameMomentAs(dataInicio) || log.dataHora.isAfter(dataInicio)) && 
             (log.dataHora.isAtSameMomentAs(dataFim) || log.dataHora.isBefore(dataFim));
    }).toList();
  }

  /// Registra uma nova atividade no log
  ///
  /// Este método é usado para registrar todas as operações CRUD
  /// realizadas no sistema.
  Future<void> registrarLog(LogAtividade log) async {
    logs.add(log);
    await salvarDadosSincronizado();
    logInfo('Log registrado: ${log.tipoAcao.name} - ${log.entidade} - ${log.usuarioNome}');
  }

  /// Cria e registra um log de atividade
  Future<void> criarERegistrarLog({
    required TipoAcao tipoAcao,
    required String entidade,
    int? entidadeId,
    required int usuarioId,
    required String usuarioNome,
    String detalhes = '',
  }) async {
    final log = LogAtividade(
      id: gerarProximoId(),
      tipoAcao: tipoAcao,
      entidade: entidade,
      entidadeId: entidadeId,
      usuarioId: usuarioId,
      usuarioNome: usuarioNome,
      detalhes: detalhes,
    );
    await registrarLog(log);
  }

  /// Gera o próximo ID disponível
  int gerarProximoId() {
    if (logs.isEmpty) {
      return 1;
    }
    return logs.map((log) => log.id).reduce((a, b) => a > b ? a : b) + 1;
  }

  /// Limpa logs antigos (opcional - para manutenção)
  ///
  /// Remove logs mais antigos que a data especificada.
  Future<void> limparLogsAntigos(DateTime dataLimite) async {
    final logsAntigos = logs.where((log) => log.dataHora.isBefore(dataLimite)).length;
    logs.removeWhere((log) => log.dataHora.isBefore(dataLimite));
    await salvarDadosSincronizado();
    logInfo('Logs antigos removidos: $logsAntigos registros');
  }

  /// Public method to save data (for Flutter GUI)
  @Deprecated('Use salvarDadosSincronizado() para operações seguras')
  void salvarDados() => _salvarDados();

  /// Salva dados de forma segura e sincronizada
  ///
  /// Utiliza um lock para serializar o acesso ao arquivo e recarrega
  /// os dados antes de salvar para mesclar alterações de outras instâncias.
  Future<void> salvarDadosSincronizado() async {
    await _getLock().synchronized(() async {
      // Recarrega dados do arquivo para obter a versão mais recente
      final dadosAtuais = await _carregarDadosDoDisco();

      // Obtém o maior ID existente para evitar conflitos
      int maiorId = 0;
      for (final log in dadosAtuais) {
        if (log.id > maiorId) {
          maiorId = log.id;
        }
      }

      // Mescla dados: adiciona novos logs
      for (final log in logs) {
        final existe = dadosAtuais.any((l) => l.id == log.id);
        if (!existe) {
          dadosAtuais.add(log);
          if (log.id > maiorId) {
            maiorId = log.id;
          }
        }
      }

      // Atualiza cache em memória com dados mesclados
      logs = dadosAtuais;

      // Salva dados mesclados no arquivo
      _salvarDados();
    });
  }

  /// Carrega dados do arquivo JSON
  void _carregarDados() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
        logs = jsonList.map((json) => LogAtividade.fromJson(json as Map<String, dynamic>)).toList();
      } catch (e, stackTrace) {
        logError('Erro ao carregar logs de atividade: $e', stackTrace);
        logs = [];
      }
    }
  }

  /// Carrega dados do disco sem modificar o estado interno
  Future<List<LogAtividade>> _carregarDadosDoDisco() async {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
        return jsonList.map((json) => LogAtividade.fromJson(json as Map<String, dynamic>)).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  /// Obtém ou cria um lock para o arquivo específico
  Lock _getLock() {
    return _fileLocks.putIfAbsent(dataFile, Lock.new);
  }

  /// Salva dados no arquivo JSON de forma segura
  void _salvarDados() {
    final file = File(dataFile);
    file.parent.createSync(recursive: true);
    final jsonString = jsonEncode(logs.map((log) => log.toJson()).toList());
    file.writeAsStringSync(jsonString);
  }
}
