import 'package:system_loja/core/managers/configuration_repository.dart';
import 'package:system_loja/core/repository/cliente_repository.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/cliente_dao.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

class AppInjection {
  static AppInjection? _instance;
  static AppInjection get instance {
    _instance ??= AppInjection._internal();
    return _instance!;
  }
  late final AppDatabase appDatabase = AppDatabase();
  late final ClienteRepository clienteRepository =
      ClienteRepository(ClienteDao(appDatabase));
  late final SettingsService settingsService = SettingsService.injection();
  late final ConfigurationRepository configurationRepository =
      ConfigurationRepository.injection();
  AppInjection._internal();
  Future<void> initializeDependencies() async {
    await configurationRepository.initializeDependencies();
  }
   
}

abstract interface class AppInjectionInterface {
  Future<void> initializeDependencies();
}
