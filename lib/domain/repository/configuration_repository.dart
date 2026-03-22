import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/interface/i_configuration_repository.dart';
import 'package:system_loja/core/interface/i_log_repository.dart';
import 'package:system_loja/core/interface/i_settings_service.dart';
import 'package:system_loja/data/entry/configuration_repository_cache.dart';
import 'package:system_loja/data/cache/cache_manager.dart';
 
import '../../core/settings/app_settings.dart';

const String keyConfigurationRepositoryCache = 'configuration_repository_cache';

/// Gerenciador de Configurações do Sistema
///
/// Responsável por carregar, salvar e gerenciar as configurações
/// do sistema usando persistência em arquivo JSON.
class ConfigurationRepository
    with LoggerClassMixin
    implements IConfigurationRepository {
  /// Configuração atual do sistema
  AppSettings _configuracao = AppSettings.createDefaultSettings();
  final ILogRepository _logRepository;
  final ISettingsService _settingsService;
  ConfigurationRepository({
    required ILogRepository logRepository,
    required ISettingsService settingsService,
  }) : _logRepository = logRepository,
       _settingsService = settingsService;

  CacheManager get _cache => CacheManager.instance;

  /// Limpa todos os dados do sistema
  ///
  /// Remove todos os clientes, produtos, notas fiscais e logs.
  /// Mantém as configurações atuais.
  @override
  Future<AppSettings> clearAllData() async {
    await _cache.clearAll();

    logInfo('Todos os dados foram limpos com sucesso');
    await _salvarDados();
    return _configuracao;
  }

  @override
  Future<AppSettings> clearOldLogs() async {
    final int diasManterLogs = _configuracao.diasManterLogs;
    if (diasManterLogs > 0) {
      final DateTime dataLimite = DateTime.now().subtract(
        Duration(days: diasManterLogs),
      );
      await _logRepository.clearOldLogs(dataLimite);
    }
    await _salvarDados();
    return _configuracao;
  }

  /// Realiza backup dos dados do sistema
  ///
  /// Cria uma cópia dos arquivos JSON em um diretório de backup
  /// com timestamp.
  @override
  Future<AppSettings> createBackup(String directoryPath) async {
    try {
      final backupFiles = await _cache.createBackup(directoryPath);

      logInfo('Backup realizado com sucesso: $backupFiles arquivos copiados');
      return _configuracao;
    } catch (e, stackTrace) {
      logError('Erro ao realizar backup: $e', stackTrace);
      return _configuracao;
    }
  }

  /// Carrega a configuração atual do sistema
  @override
  Future<AppSettings> loadConfiguration() async {
    await _carregarDados();
    return _configuracao;
  }

  /// Restaura configurações para valores padrão
  @override
  Future<AppSettings> resetToDefaults() async {
    _configuracao = AppSettings.createDefaultSettings();
    await _salvarDados();
    logInfo('Configurações restauradas para padrão');
    return _configuracao;
  }

  /// Restaura um backup das configurações e dados do sistema.
  ///
  /// Após restaurar, recarrega as configurações para refletir o conteúdo
  /// do backup restaurado. Em caso de falha, a exceção é relançada para
  /// que a camada de apresentação possa tratá-la adequadamente.
  @override
  Future<AppSettings> restoreBackup(String direBackup) async {
    try {
      await _cache.restoreBackupFrom(direBackup);
      await _carregarDados();

      logInfo('Restauração de backup realizada com sucesso');
      return _configuracao;
    } catch (e, stackTrace) {
      logError('Erro ao restaurar backup: $e', stackTrace);
      rethrow;
    }
  }

  /// Atualiza a configuração do sistema
  ///
  /// Salva automaticamente após atualizar.
  @override
  Future<AppSettings> updateAppSettings(AppSettings novaConfiguracao) async {
    _configuracao = novaConfiguracao;
    await _salvarDados();
    _settingsService.updateSettings(
      novaConfiguracao.corPrimaria,
      novaConfiguracao.temaEscuro,
    );
    logInfo('Configuração atualizada com sucesso');
    return _configuracao;
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
      _settingsService.updateSettings(
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
