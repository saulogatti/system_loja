import 'package:system_loja/core/settings/app_settings.dart';

/// Interface que define o contrato para operações de configuração do sistema.
///
/// Esta interface gerencia as configurações globais da aplicação,
/// incluindo backup/restore, limpeza de dados e reset de configurações.
///
/// Todas as operações retornam [AppSettings] atualizado após a execução,
/// permitindo atualização imediata da UI.
///
/// Exemplo de uso:
/// ```dart
/// final repository = appInjection.get<ConfigurationRepository>();
/// final novasConfigs = await repository.loadConfiguration();
/// print('Tema escuro: ${novasConfigs.darkMode}');
/// ```
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
  /// - [AppSettings] atualizado após limpeza
  Future<AppSettings> clearAllData();

  /// Remove logs antigos do sistema baseado na configuração de retenção.
  ///
  /// A data de corte é determinada pelas configurações da aplicação.
  ///
  /// Retorna:
  /// - [AppSettings] atualizado após limpeza
  Future<AppSettings> clearOldLogs();

  /// Cria um backup completo do sistema no diretório especificado.
  ///
  /// O backup inclui banco de dados, configurações e logs.
  ///
  /// Parâmetros:
  /// - [directoryPath]: Caminho do diretório onde o backup será salvo
  ///
  /// Retorna:
  /// - [AppSettings] atualizado após criação do backup
  ///
  /// Lança:
  /// - Exception se o diretório não existir ou não tiver permissão de escrita
  Future<AppSettings> createBackup(String directoryPath);

  /// Carrega as configurações salvas da aplicação.
  ///
  /// Se nenhuma configuração existir, retorna configurações padrão.
  ///
  /// Retorna:
  /// - [AppSettings] com as configurações carregadas
  Future<AppSettings> loadConfiguration();

  /// Restaura todas as configurações para os valores padrão.
  ///
  /// Mantém os dados do sistema (clientes, produtos, vendas), mas
  /// reseta preferências de tema, idioma, etc.
  ///
  /// Retorna:
  /// - [AppSettings] com valores padrão
  Future<AppSettings> resetToDefaults();

  /// Restaura um backup previamente criado.
  ///
  /// **ATENÇÃO**: Esta operação substitui todos os dados atuais.
  ///
  /// Parâmetros:
  /// - [direBackup]: Caminho do diretório contendo o backup
  ///
  /// Retorna:
  /// - [AppSettings] atualizado após restauração
  ///
  /// Lança:
  /// - Exception se o backup for inválido ou corrompido
  Future<AppSettings> restoreBackup(String direBackup);

  /// Atualiza as configurações da aplicação.
  ///
  /// Persiste as novas configurações e retorna o objeto atualizado.
  ///
  /// Parâmetros:
  /// - [novaConfiguracao]: Objeto AppSettings com novas configurações
  ///
  /// Retorna:
  /// - [AppSettings] após persistência
  Future<AppSettings> updateAppSettings(AppSettings novaConfiguracao);
}
