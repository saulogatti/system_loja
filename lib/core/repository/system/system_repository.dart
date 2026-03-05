import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';
import 'package:system_loja/data/database/dao/system_dao.dart';

class SystemRepository implements ISystemRepository {
  final SystemDao _systemDao;
  SystemRepository({required SystemDao systemDao}) : _systemDao = systemDao;
  @override
  Future<SystemConfiguration?> getSystemConfiguration() async {
    final systemConfiguration = await _systemDao.getSystemConfiguration();
    if (systemConfiguration == null) {
      await _systemDao.saveSystemConfiguration(
        SystemConfiguration(
          priceConfiguration: PriceConfiguration(types: [.card, .pix]),
          registrationDate: DateTime.now(),
          lastUpdatedDate: DateTime.now(),
          systemUserData: SystemUserData(
            name: 'Sistema de Gerenciamento de Loja',
            email: 'demo@demo.com',
            systemKey: 'demo',
          ),
        ),
      );
      return systemConfiguration;
    }
    return systemConfiguration;
  }

  @override
  Future<void> saveSystemConfiguration(SystemConfiguration data) {
    return _systemDao.saveSystemConfiguration(data);
  }
}
