import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/data/database/table/system/system_records.dart';
import 'package:system_loja/data/models/system_configuration_data.dart';

/// Codec de importação/exportação JSON de [SystemConfiguration].
///
/// {@category dados}
/// {@subCategory Sistema}
///
/// Não substitui a persistência Drift em [SystemRecords].
class SystemConfigurationCodec {
  SystemConfigurationCodec._();

  /// Reconstrói [SystemConfiguration] a partir do JSON de [SystemConfigurationData].
  static SystemConfiguration fromJson(Map<String, dynamic> json) =>
      SystemConfigurationData.fromJson(json).toDomain();

  /// Serializa [SystemConfiguration] no contrato JSON de [SystemConfigurationData].
  static Map<String, dynamic> toJson(SystemConfiguration value) =>
      SystemConfigurationData.fromDomain(value).toJson();
}
