import 'package:system_loja/core/managers/configuration_repository.dart';
import 'package:system_loja/core/repository/system/log_repository.dart';
import 'package:system_loja/core/services/code_generator_service.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/screens/route/route_app.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

class AppInjection {
  static AppInjection? _instance;
  static AppInjection get instance {
    _instance ??= AppInjection._internal();
    return _instance!;
  }

  AppDatabase appDatabase = AppDatabase();
  SystemDatabase systemDatabase = SystemDatabase();

  late final SettingsService settingsService = SettingsService.injection();

  late final LogRepository logRepository = LogRepository();

  late final RouteApp routeApp = RouteApp();
  late final CodeGeneratorService codeGeneratorService = CodeGeneratorService(
    productDao: appDatabase.productDao,
    invoiceDao: appDatabase.invoiceDao,
  );

  AppInjection._internal();

  Future<void> initializeDependencies() async {
    // Inicializações assíncronas, se necessário
    final configurationRepository = ConfigurationRepository();
    final settings = await configurationRepository.loadConfiguration();
    settingsService.updateSettings(settings.corPrimaria, settings.temaEscuro);
    await systemDatabase.customStatement('PRAGMA foreign_keys = ON;');
  }
}

abstract interface class AppInjectionInterface {
  Future<void> initializeDependencies();
}
