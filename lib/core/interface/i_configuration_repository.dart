import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/core/utils/command_result.dart';

/// Interface que define o contrato para operações de configuração do sistema.
///
/// Esta interface gerencia as configurações globais da aplicação,
/// incluindo backup/restore, limpeza de dados e reset de configurações.
///
/// Todas as operações retornam [ResultStatus] com [AppSettings] em sucesso
/// e mensagem de erro em texto — sem propagar exceções para a UI.
///
/// Veja também:
/// - [AppSettings] - modelo de configurações da aplicação
abstract interface class IConfigurationRepository {
  /// Limpa todos os dados do sistema (clientes, produtos, vendas, etc.).
  Future<ResultStatus<AppSettings, String>> clearAllData();

  /// Remove logs antigos conforme retenção configurada.
  Future<ResultStatus<AppSettings, String>> clearOldLogs();

  /// Cria backup completo no diretório informado.
  Future<ResultStatus<AppSettings, String>> createBackup(String directoryPath);

  /// Carrega configurações salvas (ou padrão se não houver / em caso recuperável).
  Future<ResultStatus<AppSettings, String>> loadConfiguration();

  /// Restaura preferências para valores padrão (mantém dados de negócio).
  Future<ResultStatus<AppSettings, String>> resetToDefaults();

  /// Restaura dados a partir de um backup existente.
  Future<ResultStatus<AppSettings, String>> restoreBackup(String direBackup);

  /// Persiste e aplica novas configurações.
  Future<ResultStatus<AppSettings, String>> updateAppSettings(
    AppSettings novaConfiguracao,
  );
}
