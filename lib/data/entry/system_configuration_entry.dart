import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/data/entry/system_user_data_entry.dart';

class SystemConfigurationEntry extends SystemConfiguration {
  SystemConfigurationEntry({
    required super.id,
    required super.priceConfiguration,
    required SystemUserDataEntry systemUserData,
    super.productCategories,
    super.registrationDate,
    super.lastUpdatedDate,
  }) : super(systemUserData: systemUserData);

  factory SystemConfigurationEntry.fromSystemConfiguration(SystemConfiguration systemConfiguration) {
    return SystemConfigurationEntry(
      id: systemConfiguration.id,
      priceConfiguration: systemConfiguration.priceConfiguration,
      systemUserData: SystemUserDataEntry.fromSystemUserData(systemConfiguration.systemUserData),
      productCategories: systemConfiguration.productCategories,
      registrationDate: systemConfiguration.registrationDate,
      lastUpdatedDate: systemConfiguration.lastUpdatedDate,
    );
  }
}
