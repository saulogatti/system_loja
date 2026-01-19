import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/managers/configuration_repository_cache.dart';
import 'package:system_loja/data/cache/cache_manager.dart';

import '../settings/app_settings.dart';

const String keyConfigurationRepositoryCache = 'configuration_repository_cache';

/// Gerenciador de Configurações do Sistema
///
/// Responsável por carregar, salvar e gerenciar as configurações
/// do sistema usando persistência em arquivo JSON.
class ConfigurationRepository with LoggerClassMixin {
  /// Configuração atual do sistema
  AppSettings _configuracao = AppSettings.createDefaultSettings();

  ConfigurationRepository() {
    _carregarDados();
  }

  /// Obtém a configuração atual
  AppSettings get configuracao => _configuracao;

  CacheManager get _cache => CacheManager.instance;

  /// Atualiza a configuração do sistema
  ///
  /// Salva automaticamente após atualizar.
  Future<void> atualizarConfiguracao(AppSettings novaConfiguracao) async {
    _configuracao = novaConfiguracao;
    _salvarDados();
    logInfo('Configuração atualizada com sucesso');
  }

  Future<dynamic> limparLogsAntigos() async {}

  /// Limpa todos os dados do sistema
  ///
  /// Remove todos os clientes, produtos, notas fiscais e logs.
  /// Mantém as configurações atuais.
  Future<bool> limparTodosDados() async {
    try {
      await _cache.clearAll();

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
      final backupFiles = await _cache.createBackup(_configuracao.localBackup);

      logInfo('Backup realizado com sucesso: $backupFiles arquivos copiados');
      return backupFiles;
    } catch (e, stackTrace) {
      logError('Erro ao realizar backup: $e', stackTrace);
      return false;
    }
  }

  /// Restaura configurações para valores padrão
  Future<void> restaurarPadrao() async {
    _configuracao = AppSettings.createDefaultSettings();
    _salvarDados();
    logInfo('Configurações restauradas para padrão');
  }

  /// Carrega dados do arquivo JSON
  Future<void> _carregarDados() async {
    final file = await _cache.get<ConfigurationRepositoryCache>(
      keyConfigurationRepositoryCache,
      ConfigurationRepositoryCache.fromJson,
    );
    if (file != null) {
      try {
        _configuracao = file.configuracao;
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

  /// Verifica se um log é recente baseado na data limite
  ///
  /// Retorna true se o log deve ser mantido, false se deve ser removido.
  /// Mantém logs com formato inválido por segurança.
  // ignore: unused_element
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
    final file = ConfigurationRepositoryCache(configuracao: _configuracao);
    _cache.set(file);
  }
}
