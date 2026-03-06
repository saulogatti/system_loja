import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';
import 'package:system_loja/data/database/dao/system_dao.dart';

class SystemRepository implements ISystemRepository {
  final SystemDao _systemDao;
  SystemRepository({required SystemDao systemDao}) : _systemDao = systemDao;
  @override
  Future<SystemConfiguration> getSystemConfiguration() async {
    SystemConfiguration? systemConfiguration = await _systemDao.getSystemConfiguration();
    if (systemConfiguration == null) {
      systemConfiguration = _createDefaultConfiguration(1);
      await _systemDao.saveSystemConfiguration(systemConfiguration);
    }
    return systemConfiguration;
  }

  @override
  Future<SystemConfiguration> resetToDefaultConfiguration() async {
    final systemConfiguration = await getSystemConfiguration();
    final defaultConfiguration = _createDefaultConfiguration(systemConfiguration.id);
    await _systemDao.saveSystemConfiguration(defaultConfiguration);
    return defaultConfiguration;
  }

  @override
  Future<void> saveSystemConfiguration(SystemConfiguration data) {
    return _systemDao.saveSystemConfiguration(data);
  }

  SystemConfiguration _createDefaultConfiguration(int id) {
    return SystemConfiguration(
      id: id,
      priceConfiguration: PriceConfiguration(
        types: const [PaymentMethodType.cash, PaymentMethodType.pix],
        measurementUnits: const ['UN', 'KG'],
        reportConfiguration: ReportConfiguration(),
      ),
      systemUserData: SystemUserData.defaultObject(),
    );
  }
}
