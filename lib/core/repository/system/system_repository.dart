import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/data/database/dao/system_dao.dart';

class SystemRepository implements ISystemRepository {
  final SystemDao _systemDao;
  SystemRepository({required SystemDao systemDao}) : _systemDao = systemDao;
  @override
  Future<SystemConfiguration?> getSystemConfiguration() {
    return _systemDao.getSystemConfiguration();
  }

  @override
  Future<void> saveSystemConfiguration(SystemConfiguration data) {
    return _systemDao.saveSystemConfiguration(data);
  }
}
