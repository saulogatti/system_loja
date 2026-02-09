import 'package:system_loja/core/models/system_config/system_configuration.dart';

abstract interface class ISystemRepository {
  Future<SystemConfiguration?> getSystemConfiguration();
  Future<void> saveSystemConfiguration(SystemConfiguration data);
}