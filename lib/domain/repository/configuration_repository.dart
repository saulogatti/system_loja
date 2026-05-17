import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/constants/cache_keys.dart';
import 'package:system_loja/core/interface/i_configuration_repository.dart';
import 'package:system_loja/core/interface/i_settings_service.dart';
import 'package:system_loja/core/utils/result_status.dart';
import 'package:system_loja/data/cache/cache_manager.dart';
import 'package:system_loja/data/entry/app_settings_entry.dart';
import 'package:system_loja/data/entry/configuration_cache_entry.dart';

import '../../core/settings/app_settings.dart';

//TODO: Refatorar para tirar mistura de data e domain, deixando este repositório apenas com lógica de domínio e delegando persistência para camada de dados. Talvez criar um ConfigurationService para lidar com cache e arquivos, e este repositório só chamar o service e mapear erros para mensagens amigáveis.
/// Repositório para gerenciamento de configurações da aplicação.
///
/// Persiste e recupera [AppSettings] via [CacheManager] e aplica o tema
/// (cor primária e modo escuro) em tempo real via [ISettingsService].
/// Todos os erros são capturados internamente e devolvidos como
/// [ResultStatus.error] com mensagem amigável.
///
/// Veja também:
/// - [IConfigurationRepository] - contrato da interface
/// - [AppSettings] - modelo de configurações
class ConfigurationRepository with LoggerClassMixin implements IConfigurationRepository {
  AppSettings _configuration = AppSettings.createDefaultSettings();

  final ISettingsService _settingsService;
  final CacheManager _cache;
  ConfigurationRepository({required ISettingsService settingsService, required CacheManager cache})
    : _cache = cache,
      _settingsService = settingsService;

  /// Limpa todos os dados do sistema armazenados em cache.
  ///
  /// Após a limpeza, salva as configurações padrão.
  /// Retorna [ResultStatus] com [AppSettings] atualizado após limpeza.
  @override
  Future<ResultStatus<AppSettings, String>> clearAllData() async {
    try {
      await _cache.clearAll();
      logInfo('Todos os dados foram limpos com sucesso');
      await _salvarDados();
      return ResultStatus.success(_configuration);
    } catch (e, stackTrace) {
      logError('Erro ao limpar dados: $e', stackTrace);
      return ResultStatus.error('Erro ao limpar todos os dados do sistema.');
    }
  }

  /// Remove logs anteriores ao período de retenção definido nas configurações.
  ///
  /// Usa [AppSettings.diasManterLogs] para calcular a data de corte.
  /// Se o valor for 0, nenhum log é removido.
  /// Retorna [ResultStatus] com [AppSettings] atualizado.
  @override
  Future<ResultStatus<AppSettings, String>> clearOldLogs() async {
    try {
      // final int diasManterLogs = _configuration.diasManterLogs;
      // if (diasManterLogs > 0) {
      //   final DateTime dataLimite = DateTime.now().subtract(
      //     Duration(days: diasManterLogs),
      //   );
      //   final logResult = await _logRepository.clearOldLogs(dataLimite);
      //   if (logResult.hasError) {
      //     return ResultStatus.error(logResult.asError);
      //   }
      // }
      await _salvarDados();
      return ResultStatus.success(_configuration);
    } catch (e, stackTrace) {
      logError('Erro ao limpar logs antigos: $e', stackTrace);
      return ResultStatus.error('Erro ao limpar logs antigos.');
    }
  }

  /// Realiza backup dos dados do sistema
  ///
  /// Cria uma cópia dos arquivos JSON em um diretório de backup
  /// com timestamp.
  @override
  Future<ResultStatus<AppSettings, String>> createBackup(String directoryPath) async {
    try {
      final backupFiles = await _cache.createBackup(directoryPath);
      if (!backupFiles) {
        return ResultStatus.error('Não foi possível concluir o backup no diretório selecionado.');
      }

      logInfo('Backup realizado com sucesso: diretório $directoryPath');
      return ResultStatus.success(_configuration);
    } catch (e, stackTrace) {
      logError('Erro ao realizar backup: $e', stackTrace);
      return ResultStatus.error('Erro ao realizar backup.');
    }
  }

  /// Carrega as configurações salvas do cache.
  ///
  /// Se nenhuma configuração existir, retorna [AppSettings.createDefaultSettings].
  /// Também aplica tema (cor e modo escuro) via [ISettingsService].
  @override
  Future<ResultStatus<AppSettings, String>> loadConfiguration() async {
    try {
      await _carregarDados();
      return ResultStatus.success(_configuration);
    } catch (e, stackTrace) {
      logError('Erro ao carregar configurações: $e', stackTrace);
      return ResultStatus.error('Erro ao carregar configurações do sistema.');
    }
  }

  /// Restaura as configurações para os valores padrão ([AppSettings.createDefaultSettings]).
  ///
  /// Persiste as configurações padrão e retorna o objeto atualizado.
  @override
  Future<ResultStatus<AppSettings, String>> resetToDefaults() async {
    try {
      _configuration = AppSettings.createDefaultSettings();
      await _salvarDados();
      logInfo('Configurações restauradas para padrão');
      return ResultStatus.success(_configuration);
    } catch (e, stackTrace) {
      logError('Erro ao restaurar configurações padrão: $e', stackTrace);
      return ResultStatus.error('Erro ao restaurar configurações padrão.');
    }
  }

  /// Restaura um backup das configurações e dados do sistema.
  ///
  /// Após restaurar, recarrega as configurações para refletir o conteúdo
  /// do backup restaurado. Em caso de falha, retorna erro para a
  /// camada de apresentação tratar de forma padronizada.
  @override
  Future<ResultStatus<AppSettings, String>> restoreBackup(String direBackup) async {
    try {
      await _cache.restoreBackupFrom(direBackup);
      await _carregarDados();
      logInfo('Restauração de backup realizada com sucesso');
      return ResultStatus.success(_configuration);
    } catch (e, stackTrace) {
      logError('Erro ao restaurar backup: $e', stackTrace);
      return ResultStatus.error('Erro ao restaurar backup.');
    }
  }

  /// Atualiza as configurações da aplicação e aplica o tema imediatamente.
  ///
  /// Persiste [novaConfiguracao] no cache e notifica [ISettingsService]
  /// para atualizar cor primária e modo escuro em toda a UI.
  @override
  Future<ResultStatus<AppSettings, String>> updateAppSettings(AppSettings novaConfiguracao) async {
    try {
      _configuration = novaConfiguracao;
      await _salvarDados();
      _settingsService.updateSettings(novaConfiguracao.corPrimaria, novaConfiguracao.temaEscuro);
      logInfo('Configuração atualizada com sucesso');
      return ResultStatus.success(_configuration);
    } catch (e, stackTrace) {
      logError('Erro ao atualizar configurações: $e', stackTrace);
      return ResultStatus.error('Erro ao salvar configurações.');
    }
  }

  /// Carrega dados do arquivo JSON
  Future<void> _carregarDados() async {
    final file = await _cache.get<ConfigurationCacheEntry>(
      keyConfigurationRepositoryCache,
      ConfigurationCacheEntry.fromJson,
    );
    if (file != null) {
      _configuration = file.configuracao.toAppSettings();
      logInfo('Configurações carregadas com sucesso');
    } else {
      _configuration = AppSettings.createDefaultSettings();
    }
    _settingsService.updateSettings(_configuration.corPrimaria, _configuration.temaEscuro);
  }

  Future<void> _salvarDados() async {
    final file = ConfigurationCacheEntry(
      configuracao: AppSettingsEntry.fromAppSettings(_configuration),
    );
    await _cache.set(file);
  }
}
