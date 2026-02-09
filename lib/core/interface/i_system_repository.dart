import 'package:system_loja/core/models/system_config/system_configuration.dart';

/// Interface que define o contrato para operações de configuração do sistema.
///
/// Esta interface gerencia as configurações técnicas e de baixo nível
/// do sistema, como parâmetros de inicialização, versões, e metadados.
///
/// Diferente de [IConfigurationRepository] que gerencia preferências do
/// usuário, esta interface lida com configurações do próprio sistema.
///
/// Exemplo de uso:
/// ```dart
/// final repository = AppInjection.instance.systemRepository;
/// 
/// final config = await repository.getSystemConfiguration();
/// if (config != null) {
///   print('Versão: ${config.version}');
/// }
/// ```
///
/// Veja também:
/// - [SystemConfiguration] - modelo de configuração do sistema
/// - [IConfigurationRepository] - para configurações de usuário
abstract interface class ISystemRepository {
  /// Retorna as configurações atuais do sistema.
  ///
  /// Retorna null se nenhuma configuração foi inicializada ainda.
  ///
  /// Retorna:
  /// - [SystemConfiguration] com as configurações ou null se não existir
  Future<SystemConfiguration?> getSystemConfiguration();

  /// Salva as configurações do sistema.
  ///
  /// Persiste as configurações técnicas do sistema para uso futuro.
  ///
  /// Parâmetros:
  /// - [data]: Objeto SystemConfiguration com as configurações a serem salvas
  Future<void> saveSystemConfiguration(SystemConfiguration data);
}