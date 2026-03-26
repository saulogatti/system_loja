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
  ///
  /// **ATENÇÃO**: Esta operação é irreversível. Considere criar um backup
  /// antes usando [createBackup].
  ///
  /// Retorna:
  /// - [ResultStatus] com [AppSettings] atualizado após limpeza
  Future<ResultStatus<AppSettings, String>> clearAllData();

  /// Remove logs antigos do sistema baseado na configuração de retenção.
  ///
  /// A data de corte é determinada pelas configurações da aplicação.
  ///
  /// Retorna:
  /// - [ResultStatus] com [AppSettings] atualizado após limpeza
  Future<ResultStatus<AppSettings, String>> clearOldLogs();

  /// Cria um backup completo do sistema no diretório especificado.
  ///
  /// O backup inclui banco de dados, configurações e logs.
  ///
  /// Parâmetros:
  /// - [directoryPath]: Caminho do diretório onde o backup será salvo
  ///
  /// Retorna:
  /// - [ResultStatus] com [AppSettings] após criação do backup
  Future<ResultStatus<AppSettings, String>> createBackup(String directoryPath);

  /// Carrega as configurações salvas da aplicação.
  ///
  /// Se nenhuma configuração existir, retorna configurações padrão.
  ///
  /// Retorna:
  /// - [ResultStatus] com [AppSettings] carregado
  Future<ResultStatus<AppSettings, String>> loadConfiguration();

  /// Restaura todas as configurações para os valores padrão.
  ///
  /// Mantém os dados do sistema (clientes, produtos, vendas), mas
  /// reseta preferências de tema, idioma, etc.
  ///
  /// Retorna:
  /// - [ResultStatus] com [AppSettings] com valores padrão
  Future<ResultStatus<AppSettings, String>> resetToDefaults();

  /// Restaura um backup previamente criado.
  ///
  /// **ATENÇÃO**: Esta operação substitui todos os dados atuais.
  ///
  /// Parâmetros:
  /// - [direBackup]: Caminho do diretório contendo o backup
  ///
  /// Retorna:
  /// - [ResultStatus] com [AppSettings] atualizado após restauração
  Future<ResultStatus<AppSettings, String>> restoreBackup(String direBackup);

  /// Atualiza as configurações da aplicação.
  ///
  /// Persiste as novas configurações e retorna o objeto atualizado.
  ///
  /// Parâmetros:
  /// - [novaConfiguracao]: Objeto AppSettings com novas configurações
  ///
  /// Retorna:
  /// - [ResultStatus] com [AppSettings] após persistência
  Future<ResultStatus<AppSettings, String>> updateAppSettings(AppSettings novaConfiguracao);
}
