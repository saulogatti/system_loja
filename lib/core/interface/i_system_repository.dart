import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/core/utils/command_result.dart';

/// Interface que define o contrato para operações de configuração do sistema.
///
/// Esta interface gerencia as configurações técnicas e de baixo nível
/// do sistema, como parâmetros de inicialização, versões, e metadados.
///
/// Diferente de [IConfigurationRepository] que gerencia preferências do
/// usuário, esta interface lida com configurações do próprio sistema.
///
/// Todas as operações retornam [ResultStatus] com mensagem de erro em texto
/// para a camada de apresentação — sem propagar exceções.
///
/// Veja também:
/// - [SystemConfiguration] - modelo de configuração do sistema
/// - [IConfigurationRepository] - para configurações de usuário
abstract interface class ISystemRepository {
  /// Retorna as configurações atuais do sistema (cria padrão se necessário).
  Future<ResultStatus<SystemConfiguration, String>> getSystemConfiguration();

  /// Importa configuração a partir de JSON e persiste.
  Future<ResultStatus<SystemConfiguration, String>> importConfigurationFromJson(
    String jsonContent,
  );

  Future<ResultStatus<SystemConfiguration, String>>
  resetToDefaultConfiguration();

  /// Salva as configurações do sistema.
  Future<ResultStatus<void, String>> saveSystemConfiguration(
    SystemConfiguration data,
  );
}
