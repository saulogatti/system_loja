import 'package:system_loja/core/managers/configuration_repository.dart';
import 'package:system_loja/core/repository/cliente_repository.dart';
import 'package:system_loja/core/repository/product_repository.dart';
import 'package:system_loja/core/repository/sales_repository.dart';
import 'package:system_loja/core/repository/system/log_repository.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/dao/cliente_dao.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/screens/route/route_app.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

class AppInjection {
  static AppInjection? _instance;
  static AppInjection get instance {
    _instance ??= AppInjection._internal();
    return _instance!;
  }

  final AppDatabase appDatabase = AppDatabase();
  final SystemDatabase systemDatabase = SystemDatabase();
  late final ClienteRepository clienteRepository = ClienteRepository(
    ClienteDao(appDatabase),
  );
  late final SettingsService settingsService = SettingsService.injection();
  late final ConfigurationRepository configurationRepository =
      ConfigurationRepository();
  late final ProductRepository productRepository = ProductRepository();
  late final LogRepository logRepository = LogRepository();
  late final SalesRepository salesRepository = SalesRepository(
    invoiceDao: appDatabase.invoiceDao,
  );
  late final RouteApp routeApp = RouteApp();

  AppInjection._internal();
  Future<void> initializeDependencies() async {
    await configurationRepository.initializeDependencies();
  }
}

abstract interface class AppInjectionInterface {
  Future<void> initializeDependencies();
}
