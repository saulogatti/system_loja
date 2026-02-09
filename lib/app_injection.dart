import 'package:get_it/get_it.dart';
import 'package:system_loja/core/interface/i_category_repository.dart';
import 'package:system_loja/core/interface/i_company_repository.dart';
import 'package:system_loja/core/interface/i_configuration_repository.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/interface/i_log_repository.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/core/interface/i_sales_repository.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/interface/i_user_repository.dart';
import 'package:system_loja/core/managers/configuration_repository.dart';
import 'package:system_loja/core/repository/category_repository.dart';
import 'package:system_loja/core/repository/company_repository.dart';
import 'package:system_loja/core/repository/customer_repository.dart';
import 'package:system_loja/core/repository/product_repository.dart';
import 'package:system_loja/core/repository/sales_repository.dart';
import 'package:system_loja/core/repository/system/log_repository.dart';
import 'package:system_loja/core/repository/system/system_repository.dart';
import 'package:system_loja/core/repository/system/user_repository.dart';
import 'package:system_loja/core/services/code_generator_service.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/screens/route/route_app.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

final appInjection = GetIt.instance;

/// Configura as dependências da aplicação.
/// Isso é usado no main.dart para configurar as dependências da aplicação.
/// Para acessar as dependências, use o `appInjection.get<T>()` onde T é o tipo da dependência.
void setupAppInjection() {
  appInjection.registerSingleton<RouteApp>(RouteApp());
  appInjection.registerSingleton<AppDatabase>(AppDatabase());
  appInjection.registerSingleton<SystemDatabase>(SystemDatabase());
  appInjection.registerSingleton<CodeGeneratorService>(
    CodeGeneratorService(
      productDao: appInjection.get<AppDatabase>().productDao,
      invoiceDao: appInjection.get<AppDatabase>().invoiceDao,
    ),
  );
  appInjection.registerSingleton<ILogRepository>(
    LogRepository(logDao: appInjection.get<SystemDatabase>().logDao),
  );
  appInjection.registerSingleton<ICustomerRepository>(
    CustomerRepository(
      logRepository: appInjection.get<ILogRepository>(),
      customerDao: appInjection.get<AppDatabase>().customerDao,
    ),
  );
  appInjection.registerSingleton<IProductRepository>(
    ProductRepository(
      productDao: appInjection.get<AppDatabase>().productDao,
      codeGeneratorService: appInjection.get<CodeGeneratorService>(),
    ),
  );

  appInjection.registerSingleton<SettingsService>(SettingsService.injection());
  appInjection.registerSingleton<IConfigurationRepository>(
    ConfigurationRepository(
      logRepository: appInjection.get<ILogRepository>(),
      settingsService: appInjection.get<SettingsService>(),
    ),
  );
  appInjection.registerSingleton<ICompanyRepository>(
    CompanyRepository(
      logRepository: appInjection.get<ILogRepository>(),
      companyDao: appInjection.get<AppDatabase>().companyDao,
    ),
  );
  appInjection.registerSingleton<ISalesRepository>(
    SalesRepository(
      invoiceDao: appInjection.get<AppDatabase>().invoiceDao,
      codeGeneratorService: appInjection.get<CodeGeneratorService>(),
    ),
  );
  appInjection.registerSingleton<IUserRepository>(
    UserRepository(
      logRepository: appInjection.get<ILogRepository>(),
      usersDao: appInjection.get<SystemDatabase>().usersDao,
    ),
  );
  appInjection.registerSingleton<ISystemRepository>(
    SystemRepository(systemDao: appInjection.get<SystemDatabase>().systemDao),
  );
  appInjection.registerSingleton<ICategoryRepository>(
    CategoryRepository(
      categoryDao: appInjection.get<AppDatabase>().categoryDao,
    ),
  );
  appInjection.get<IConfigurationRepository>().loadConfiguration();
}
