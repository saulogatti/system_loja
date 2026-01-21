import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/managers/configuration_repository_cache.dart';
import 'package:system_loja/core/managers/log_atividade_manager.dart';
import 'package:system_loja/data/cache/cache_manager.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

import '../settings/app_settings.dart';

const String keyConfigurationRepositoryCache = 'configuration_repository_cache';

/// Gerenciador de Configurações do Sistema
///
/// Responsável por carregar, salvar e gerenciar as configurações
/// do sistema usando persistência em arquivo JSON.
class ConfigurationRepository
    with LoggerClassMixin
    implements AppInjectionInterface {
  /// Configuração atual do sistema
  AppSettings _configuracao = AppSettings.createDefaultSettings();

  ConfigurationRepository.injection();

  CacheManager get _cache => CacheManager.instance;

  /// Atualiza a configuração do sistema
  ///
  /// Salva automaticamente após atualizar.
  Future<void> atualizarConfiguracao(AppSettings novaConfiguracao) async {
    _configuracao = novaConfiguracao;
    await _salvarDados();
    AppInjection.instance.settingsService.updateSettings(
      novaConfiguracao.corPrimaria,
      novaConfiguracao.temaEscuro,
    );
    logInfo('Configuração atualizada com sucesso');
  }

  /// Carrega a configuração atual do sistema
  Future<AppSettings> carregarConfiguracao() async {
    await _carregarDados();
    return _configuracao;
  }

  @override
  Future<void> initializeDependencies() async {
    await _carregarDados();
  }

  Future<bool> limparLogsAntigos() async {
    try {
      final LogAtividadeManager logManager = LogAtividadeManager();
      final int diasManterLogs = _configuracao.diasManterLogs;
      final DateTime dataLimite = DateTime.now().subtract(
        Duration(days: diasManterLogs),
      );
      await logManager.limparLogsAntigos(dataLimite);
      return true;
    } catch (e) {
      return false;
    }
  }

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
    try {
      final file = await _cache.get<ConfigurationRepositoryCache>(
        keyConfigurationRepositoryCache,
        ConfigurationRepositoryCache.fromJson,
      );
      if (file != null) {
        _configuracao = file.configuracao;
        logInfo('Configurações carregadas com sucesso');
      } else {
        _configuracao = AppSettings.createDefaultSettings();
      }
      AppInjection.instance.settingsService.updateSettings(
        _configuracao.corPrimaria,
        _configuracao.temaEscuro,
      );
    } catch (e, stackTrace) {
      logError('Erro ao carregar configurações: $e', stackTrace);
      _configuracao = AppSettings.createDefaultSettings();
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
  Future<void> _salvarDados() async {
    final file = ConfigurationRepositoryCache(configuracao: _configuracao);
    await _cache.set(file);
  }
}
