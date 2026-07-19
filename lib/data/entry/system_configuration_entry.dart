import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/data/entry/system_user_data_entry.dart';

/// Linha Drift / agregado persistido para configuração do sistema (sem herdar [SystemConfiguration]).
class SystemConfigurationEntry {

  SystemConfigurationEntry({
    required this.id,
    required this.priceConfiguration,
    required this.systemUserData,
    required this.registrationDate,
    required this.lastUpdatedDate,
  });

  factory SystemConfigurationEntry.fromSystemConfiguration(
    SystemConfiguration systemConfiguration,
  ) => SystemConfigurationEntry(
      id: systemConfiguration.id,
      priceConfiguration: systemConfiguration.priceConfiguration,
      systemUserData: SystemUserDataEntry.fromSystemUserData(
        systemConfiguration.systemUserData,
      ),
      registrationDate: systemConfiguration.registrationDate,
      lastUpdatedDate: systemConfiguration.lastUpdatedDate,
    );
  final int id;
  final DateTime registrationDate;
  final DateTime lastUpdatedDate;
  final PriceConfiguration priceConfiguration;
  final SystemUserDataEntry systemUserData;

  /// Converte para domínio; categorias de produto não vêm da tabela `system_records`.
  SystemConfiguration toDomain() => SystemConfiguration(
    id: id,
    priceConfiguration: priceConfiguration,
    systemUserData: systemUserData.toDomain(),
    productCategories: [],
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}
