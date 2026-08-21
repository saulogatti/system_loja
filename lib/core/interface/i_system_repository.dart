import 'package:system_loja/core/interface/i_configuration_repository.dart' show IConfigurationRepository;
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/core/utils/result_status.dart';

/// Contrato de configuração técnica do sistema (não preferências de UI).
///
/// {@category contratos}
/// {@subCategory Sistema}
///
/// Distinto de [IConfigurationRepository]. Persistência via Drift; importação
/// e exportação JSON usam DTOs em `lib/data/entry/`. Erros voltam como
/// [ResultStatus.error].
///
/// Resolver com `appInjection.get<ISystemRepository>()`.
///
/// ```dart
/// final repository = appInjection.get<ISystemRepository>();
/// final resultado = await repository.getSystemConfiguration();
/// resultado.when(
///   onSuccess: (config) => print(config.id),
///   onError: (mensagem) => print(mensagem),
/// );
/// ```
///
/// Veja também:
/// - [SystemConfiguration] — modelo de domínio
/// - [IConfigurationRepository] — preferências do usuário
abstract interface class ISystemRepository {
  /// Remove dados de negócio e devolve a configuração atual.
  Future<ResultStatus<SystemConfiguration, String>> clearAllData();

  /// Remove logs antigos conforme a política de retenção.
  Future<ResultStatus<SystemConfiguration, String>> clearOldLogs();

  /// Exporta a configuração técnica como DTO JSON.
  Future<ResultStatus<SystemConfiguration, String>> exportConfigurationToJson();

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
  Future<ResultStatus<SystemConfiguration, String>> importConfigurationFromJson();

  /// Redefine as configurações do sistema para os valores padrão.
  ///
  /// Sobrescreve a configuração existente com os valores padrão do sistema
  /// e persiste o resultado.
  Future<ResultStatus<SystemConfiguration, String>> resetToDefaultConfiguration();

  /// Salva as configurações do sistema.
  ///
  /// Persiste as configurações técnicas do sistema para uso futuro.
  ///
  /// Parâmetros:
  /// - [data]: Objeto SystemConfiguration com as configurações a serem salvas
  Future<ResultStatus<SystemConfiguration, String>> saveSystemConfiguration(SystemConfiguration data);
}
