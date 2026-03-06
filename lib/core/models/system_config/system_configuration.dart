import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';

class SystemConfiguration extends DefaultObject {
  PriceConfiguration priceConfiguration = PriceConfiguration(types: []);
  SystemUserData systemUserData;
  List<String> productCategories = [];
  SystemConfiguration({
    PriceConfiguration? priceConfiguration,
    List<String>? productCategories,
    super.lastUpdatedDate,
    super.registrationDate,
    int? id,
    SystemUserData? systemUserData,
  }) : priceConfiguration = priceConfiguration ?? PriceConfiguration(types: []),
       productCategories = productCategories ?? [],
       systemUserData = systemUserData ?? SystemUserData.defaultObject();
}
