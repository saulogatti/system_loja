import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/data/models/system_configuration_data.dart';

/// Importação/exportação JSON de [SystemConfiguration].
class SystemConfigurationCodec {
  SystemConfigurationCodec._();

  static SystemConfiguration fromJson(Map<String, dynamic> json) =>
      SystemConfigurationData.fromJson(json).toDomain();

  static Map<String, dynamic> toJson(SystemConfiguration value) =>
      SystemConfigurationData.fromDomain(value).toJson();
}
