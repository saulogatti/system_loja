import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/constants/cache_keys.dart';
import 'package:system_loja/core/interface/i_configuration_repository.dart';
import 'package:system_loja/core/interface/i_log_repository.dart';
import 'package:system_loja/core/interface/i_settings_service.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/core/utils/repository_error_mapper.dart';
import 'package:system_loja/data/cache/cache_manager.dart';
import 'package:system_loja/data/entry/configuration_repository_cache.dart';

import '../../core/settings/app_settings.dart';

/// Gerenciador de Configurações do Sistema
///
/// Responsável por carregar, salvar e gerenciar as configurações
/// do sistema usando persistência em arquivo JSON.
class ConfigurationRepository
    with LoggerClassMixin
    implements IConfigurationRepository {
  AppSettings _configuracao = AppSettings.createDefaultSettings();
  final ILogRepository _logRepository;
  final ISettingsService _settingsService;
  ConfigurationRepository({
    required ILogRepository logRepository,
    required ISettingsService settingsService,
  }) : _logRepository = logRepository,
       _settingsService = settingsService;

  CacheManager get _cache => CacheManager.instance;

  @override
  Future<ResultStatus<AppSettings, String>> clearAllData() async {
    try {
      await _cache.clearAll();
      logInfo('Todos os dados foram limpos com sucesso');
      await _salvarDados();
      return ResultStatus.success(_configuracao);
    } catch (e, stackTrace) {
      logError('Erro ao limpar dados: $e', stackTrace);
      return ResultStatus.error(
        mensagemErroRepositorio(e, contexto: 'Falha ao limpar dados'),
      );
    }
  }

  @override
  Future<ResultStatus<AppSettings, String>> clearOldLogs() async {
    try {
      final int diasManterLogs = _configuracao.diasManterLogs;
      if (diasManterLogs > 0) {
        final DateTime dataLimite = DateTime.now().subtract(
          Duration(days: diasManterLogs),
        );
        final logResult = await _logRepository.clearOldLogs(dataLimite);
        switch (logResult) {
          case ResultError(:final resultError):
            return ResultStatus.error(resultError);
          case ResultSuccess():
            break;
        }
      }
      await _salvarDados();
      return ResultStatus.success(_configuracao);
    } catch (e, stackTrace) {
      logError('Erro ao limpar logs antigos: $e', stackTrace);
      return ResultStatus.error(
        mensagemErroRepositorio(e, contexto: 'Falha ao limpar logs antigos'),
      );
    }
  }

  @override
  Future<ResultStatus<AppSettings, String>> createBackup(
    String directoryPath,
  ) async {
    try {
      final backupFiles = await _cache.createBackup(directoryPath);
      logInfo('Backup realizado com sucesso: $backupFiles arquivos copiados');
      return ResultStatus.success(_configuracao);
    } catch (e, stackTrace) {
      logError('Erro ao realizar backup: $e', stackTrace);
      return ResultStatus.error(
        mensagemErroRepositorio(e, contexto: 'Falha ao realizar backup'),
      );
    }
  }

  @override
  Future<ResultStatus<AppSettings, String>> loadConfiguration() async {
    await _carregarDados();
    return ResultStatus.success(_configuracao);
  }

  @override
  Future<ResultStatus<AppSettings, String>> resetToDefaults() async {
    try {
      _configuracao = AppSettings.createDefaultSettings();
      await _salvarDados();
      logInfo('Configurações restauradas para padrão');
      return ResultStatus.success(_configuracao);
    } catch (e, stackTrace) {
      logError('Erro ao restaurar padrões: $e', stackTrace);
      return ResultStatus.error(
        mensagemErroRepositorio(
          e,
          contexto: 'Falha ao restaurar configurações padrão',
        ),
      );
    }
  }

  @override
  Future<ResultStatus<AppSettings, String>> restoreBackup(
    String direBackup,
  ) async {
    try {
      await _cache.restoreBackupFrom(direBackup);
      await _carregarDados();
      logInfo('Restauração de backup realizada com sucesso');
      return ResultStatus.success(_configuracao);
    } catch (e, stackTrace) {
      logError('Erro ao restaurar backup: $e', stackTrace);
      return ResultStatus.error(
        mensagemErroRepositorio(e, contexto: 'Falha ao restaurar backup'),
      );
    }
  }

  @override
  Future<ResultStatus<AppSettings, String>> updateAppSettings(
    AppSettings novaConfiguracao,
  ) async {
    try {
      _configuracao = novaConfiguracao;
      await _salvarDados();
      _settingsService.updateSettings(
        novaConfiguracao.corPrimaria,
        novaConfiguracao.temaEscuro,
      );
      logInfo('Configuração atualizada com sucesso');
      return ResultStatus.success(_configuracao);
    } catch (e, stackTrace) {
      logError('Erro ao salvar configurações: $e', stackTrace);
      return ResultStatus.error(
        mensagemErroRepositorio(e, contexto: 'Falha ao salvar configurações'),
      );
    }
  }

  Future<void> _carregarDados() async {
    try {
      final file = await _cache.get<ConfigurationRepositoryCache>(
        keyConfigurationRepositoryCache,
        ConfigurationRepositoryCache.fromJson,
      );
      if (file != null) {
        _configuracao = file.configuracao.toAppSettings();
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

  // ignore: unused_element
  bool _isLogRecent(Object log, DateTime dataLimite) {
    try {
      if (log is Map<String, dynamic> && log['data_hora'] is String) {
        final dataLog = DateTime.parse(log['data_hora'] as String);
        return dataLog.isAfter(dataLimite);
      }
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<void> _salvarDados() async {
    final file = ConfigurationRepositoryCache(
      configuracao: AppSettingsEntry.fromAppSettings(_configuracao),
    );
    await _cache.set(file);
  }
}
