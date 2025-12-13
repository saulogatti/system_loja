import 'dart:convert';
import 'dart:io';

import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:synchronized/synchronized.dart';

import '../settings/app_settings.dart';

/// Gerenciador de Configurações do Sistema
///
/// Responsável por carregar, salvar e gerenciar as configurações
/// do sistema usando persistência em arquivo JSON.
class ConfiguracaoManager  with LoggerClassMixin {
  /// Lock estático para serializar o acesso entre múltiplas instâncias
  static final Map<String, Lock> _fileLocks = {};
  final String dataFile;

  /// Configuração atual do sistema
  AppSettings _configuracao = AppSettings.createDefaultSettings();

  ConfiguracaoManager({this.dataFile = 'data/configuracao.json'}) {
    _carregarDados();
  }

  /// Obtém a configuração atual
  AppSettings get configuracao => _configuracao;

  /// Atualiza a configuração do sistema
  ///
  /// Salva automaticamente após atualizar.
  Future<void> atualizarConfiguracao(AppSettings novaConfiguracao) async {
    _configuracao = novaConfiguracao;
    await salvarDadosSincronizado();
    logInfo('Configuração atualizada com sucesso');
  }

  /// Limpa logs antigos baseado na configuração
  ///
  /// Remove logs com mais dias que o especificado em diasManterLogs.
  Future<bool> limparLogsAntigos() async {
    try {
      final file = File('data/logs_atividade.json');
      if (!file.existsSync()) {
        return true;
      }

      final jsonString = file.readAsStringSync();
      final List<dynamic> logs = jsonDecode(jsonString);

      final dataLimite = DateTime.now().subtract(
        Duration(days: _configuracao.diasManterLogs),
      );

      final logsRecentes = logs
          .where((log) => _isLogRecent(log, dataLimite))
          .toList();

      final logsRemovidos = logs.length - logsRecentes.length;

      if (logsRemovidos > 0) {
        file.writeAsStringSync(jsonEncode(logsRecentes));
        logInfo('Limpeza de logs concluída: $logsRemovidos logs removidos');
      }

      return true;
    } catch (e, stackTrace) {
      logError('Erro ao limpar logs antigos: $e', stackTrace);
      return false;
    }
  }

  /// Limpa todos os dados do sistema
  ///
  /// Remove todos os clientes, produtos, notas fiscais e logs.
  /// Mantém as configurações atuais.
  Future<bool> limparTodosDados() async {
    try {
      final arquivosParaLimpar = [
        'data/clientes.json',
        'data/produtos.json',
        'data/notas_fiscais.json',
        'data/usuarios.json',
        'data/logs_atividade.json',
      ];

      for (final arquivo in arquivosParaLimpar) {
        final file = File(arquivo);
        if (file.existsSync()) {
          file.writeAsStringSync('[]');
        }
      }

      logInfo('Todos os dados foram limpos com sucesso');
      return true;
    } catch (e, stackTrace) {
      logError('Erro ao limpar dados: $e', stackTrace);
      return false;
    }
  }

  /// Realiza backup dos dados do sistema
  ///
  /// Cria uma cópia dos arquivos JSON em um diretório de backup
  /// com timestamp.
  Future<bool> realizarBackup() async {
    try {
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final backupDir = Directory('${_configuracao.localBackup}/$timestamp');

      if (!backupDir.existsSync()) {
        backupDir.createSync(recursive: true);
      }

      // Lista de arquivos para backup
      final arquivosParaBackup = [
        'data/clientes.json',
        'data/produtos.json',
        'data/notas_fiscais.json',
        'data/usuarios.json',
        'data/logs_atividade.json',
        'data/configuracao.json',
      ];

      var arquivosCopiados = 0;
      for (final arquivo in arquivosParaBackup) {
        final file = File(arquivo);
        if (file.existsSync()) {
          final nomeArquivo = arquivo.split('/').last;
          await file.copy('${backupDir.path}/$nomeArquivo');
          arquivosCopiados++;
        }
      }

      logInfo(
        'Backup realizado com sucesso: $arquivosCopiados arquivos copiados',
      );
      return true;
    } catch (e, stackTrace) {
      logError('Erro ao realizar backup: $e', stackTrace);
      return false;
    }
  }

  /// Restaura configurações para valores padrão
  Future<void> restaurarPadrao() async {
    _configuracao = AppSettings.createDefaultSettings();
    await salvarDadosSincronizado();
    logInfo('Configurações restauradas para padrão');
  }

  /// Salva dados de forma segura e sincronizada
  ///
  /// Utiliza um lock para serializar o acesso ao arquivo.
  Future<void> salvarDadosSincronizado() async {
    await _getLock().synchronized(() async {
      _salvarDados();
    });
  }

  /// Carrega dados do arquivo JSON
  void _carregarDados() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final Map<String, dynamic> json = jsonDecode(jsonString);
        _configuracao = AppSettings.fromJson(json);
        logInfo('Configurações carregadas com sucesso');
      } catch (e, stackTrace) {
        logError('Erro ao carregar configurações: $e', stackTrace);
        _configuracao = AppSettings.createDefaultSettings();
      }
    } else {
      _configuracao = AppSettings.createDefaultSettings();
      _salvarDados(); // Cria arquivo com configurações padrão
    }
  }

  /// Obtém ou cria um lock para o arquivo específico
  Lock _getLock() {
    return _fileLocks.putIfAbsent(dataFile, Lock.new);
  }

  /// Verifica se um log é recente baseado na data limite
  ///
  /// Retorna true se o log deve ser mantido, false se deve ser removido.
  /// Mantém logs com formato inválido por segurança.
  bool _isLogRecent(Object log, DateTime dataLimite) {
    try {
      if (log is Map<String, dynamic> && log['data_hora'] is String) {
        final dataLog = DateTime.parse(log['data_hora'] as String);
        return dataLog.isAfter(dataLimite);
      }
      return true; // Mantém logs com formato inválido
    } catch (e) {
      return true; // Mantém logs com data inválida
    }
  }

  /// Salva dados no arquivo JSON
  void _salvarDados() {
    final file = File(dataFile);
    file.parent.createSync(recursive: true);
    final jsonString = jsonEncode(_configuracao.toJson());
    file.writeAsStringSync(jsonString);
  }
}
