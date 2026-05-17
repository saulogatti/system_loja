import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';

/// Configuração global do sistema (domínio).
/// Importação/exportação JSON: `SystemConfigurationCodec` em `lib/data/`.
class SystemConfiguration extends DefaultObject {
  PriceConfiguration priceConfiguration;
  SystemUserData systemUserData;
  List<String> productCategories;

  /// Define se a limpeza automática de logs antigos está habilitada
  final bool isAutoCleanEnabled;

  /// Número de dias para manter logs no sistema antes da limpeza (7-365)
  final int logRetentionDays;

  // Opções de Segurança

  /// Define se o sistema deve exigir senha ao ser aberto
  final bool isPasswordRequired;

  /// Tempo em minutos de inatividade antes de solicitar senha novamente (1-60)
  final int lockTimeoutMinutes;

  /// Define se o sistema permite gestão de múltiplos usuários
  final bool isMultiUserEnabled;
  SystemConfiguration({
    PriceConfiguration? priceConfiguration,
    List<String>? productCategories,
    super.lastUpdatedDate,
    super.registrationDate,
    super.id,
    SystemUserData? systemUserData,
    this.isAutoCleanEnabled = false,
    this.logRetentionDays = 90,
    this.isPasswordRequired = false,
    this.lockTimeoutMinutes = 15,
    this.isMultiUserEnabled = false,
  }) : priceConfiguration =
           priceConfiguration ??
           PriceConfiguration(
             types: [],
             measurementUnits: [],
             reportConfiguration: ReportConfiguration(),
           ),
       productCategories = productCategories ?? [],
       systemUserData = systemUserData ?? SystemUserData.defaultObject();

  SystemConfiguration copyWith({
    bool? isAutoCleanEnabled,
    PriceConfiguration? priceConfiguration,
    int? logRetentionDays,
    bool? isPasswordRequired,
    int? lockTimeoutMinutes,
    bool? isMultiUserEnabled,
    List<String>? productCategories,
    SystemUserData? systemUserData,
  }) {
    return SystemConfiguration(
      priceConfiguration: priceConfiguration ?? this.priceConfiguration,
      productCategories: productCategories ?? this.productCategories,
      systemUserData: systemUserData ?? this.systemUserData,
      isAutoCleanEnabled: isAutoCleanEnabled ?? this.isAutoCleanEnabled,
      logRetentionDays: logRetentionDays ?? this.logRetentionDays,
      isPasswordRequired: isPasswordRequired ?? this.isPasswordRequired,
      lockTimeoutMinutes: lockTimeoutMinutes ?? this.lockTimeoutMinutes,
      isMultiUserEnabled: isMultiUserEnabled ?? this.isMultiUserEnabled,
    );
  }
}
