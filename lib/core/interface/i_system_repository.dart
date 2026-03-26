import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/core/utils/result_status.dart';

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
/// final repository = appInjection.get<SystemRepository>();
///
/// final resultado = await repository.getSystemConfiguration();
/// resultado.when(
///   onSuccess: (config) => print('Configuração carregada: ${config.id}'),
///   onError: (erro) => print('Falha: $erro'),
/// );
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
  /// - [ResultStatus] com [SystemConfiguration]
  Future<ResultStatus<SystemConfiguration, String>> getSystemConfiguration();

  /// Importa configuração a partir de JSON e persiste.
  ///
  /// Faz parse, valida, normaliza e salva.
  /// Em caso de falha, retorna [ResultStatus.error] com mensagem amigável.
  Future<ResultStatus<SystemConfiguration, String>> importConfigurationFromJson(
    String jsonContent,
  );

  /// Redefine as configurações do sistema para os valores padrão.
  ///
  /// Sobrescreve a configuração existente com os valores padrão do sistema
  /// e persiste o resultado.
  Future<ResultStatus<SystemConfiguration, String>>
  resetToDefaultConfiguration();

  /// Salva as configurações do sistema.
  ///
  /// Persiste as configurações técnicas do sistema para uso futuro.
  ///
  /// Parâmetros:
  /// - [data]: Objeto SystemConfiguration com as configurações a serem salvas
  Future<ResultStatus<bool, String>> saveSystemConfiguration(
    SystemConfiguration data,
  );
}
