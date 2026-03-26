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

  SystemConfiguration({
    PriceConfiguration? priceConfiguration,
    List<String>? productCategories,
    super.lastUpdatedDate,
    super.registrationDate,
    super.id,
    SystemUserData? systemUserData,
  }) : priceConfiguration =
           priceConfiguration ??
           PriceConfiguration(types: [], measurementUnits: [], reportConfiguration: ReportConfiguration()),
       productCategories = productCategories ?? [],
       systemUserData = systemUserData ?? SystemUserData.defaultObject();
}
