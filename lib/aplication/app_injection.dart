import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/aplication/system_error_manager.dart';
import 'package:system_loja/core/interface/i_analytics_repository.dart';
import 'package:system_loja/core/interface/i_category_repository.dart';
import 'package:system_loja/core/interface/i_company_repository.dart';
import 'package:system_loja/core/interface/i_configuration_repository.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/interface/i_log_repository.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/core/interface/i_sales_repository.dart';
import 'package:system_loja/core/interface/i_system_error_manager.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/interface/i_user_repository.dart';
import 'package:system_loja/core/services/product_movement_report_service.dart';
import 'package:system_loja/core/services/relatorio_overview_service.dart';
import 'package:system_loja/data/cache/cache_manager.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/domain/code_generator_service.dart';
import 'package:system_loja/domain/repository/analytics_repository.dart';
import 'package:system_loja/domain/repository/category_repository.dart';
import 'package:system_loja/domain/repository/company_repository.dart';
import 'package:system_loja/domain/repository/configuration_repository.dart';
import 'package:system_loja/domain/repository/customer_repository.dart';
import 'package:system_loja/domain/repository/product_repository.dart';
import 'package:system_loja/domain/repository/sales_repository.dart';
import 'package:system_loja/domain/repository/system/log_repository.dart';
import 'package:system_loja/domain/repository/system/system_repository.dart';
import 'package:system_loja/domain/repository/system/user_repository.dart';
import 'package:system_loja/screens/route/route_app.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

final appInjection = GetIt.instance;
late LoggerPersistenceService printerLog;

/// Configura as dependências da aplicação.
/// Isso é usado no main.dart para configurar as dependências da aplicação.
/// Para acessar as dependências, use o `appInjection.get<T>()` onde T é o tipo da dependência.
void setupAppInjection() {
  printerLog = registerLogPrinterColor(
    config: ConfigLog(enableLog: kDebugMode),
  );
  appInjection.registerSingleton<RouteApp>(RouteApp());
  appInjection.registerSingleton<ProductMovementReportService>(
    ProductMovementReportService(),
  );
  appInjection.registerSingleton<RelatorioOverviewService>(
    RelatorioOverviewService(),
  );
  appInjection.registerSingleton<AppDatabase>(AppDatabase());
  appInjection.registerSingleton<SystemDatabase>(SystemDatabase());
  appInjection.registerSingleton<ISystemErrorManager>(SystemErrorManager());
  appInjection.registerSingleton<CacheManager>(CacheManager());
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
      cache: appInjection.get<CacheManager>(),
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
      invoiceItemDao: appInjection.get<AppDatabase>().invoiceItemDao,
      productDao: appInjection.get<AppDatabase>().productDao,
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
  appInjection.registerSingleton<IAnalyticsRepository>(
    AnalyticsRepository(invoiceDao: appInjection.get<AppDatabase>().invoiceDao),
  );
  unawaited(_carregarConfiguracaoInicial());
}

/// Carrega preferências da aplicação após o registro do repositório.
Future<void> _carregarConfiguracaoInicial() async {
  final resultado = await appInjection
      .get<IConfigurationRepository>()
      .loadConfiguration();
  resultado.when(
    onSuccess: (_) {},
    onError: (mensagem) =>
        debugPrint('Falha ao carregar configurações iniciais: $mensagem'),
  );
}
