import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/app_injection.dart';
import 'package:system_loja/core/interface/i_company_repository.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/interface/i_log_repository.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/core/interface/i_sales_repository.dart';
import 'package:system_loja/core/interface/i_user_repository.dart';
import 'package:system_loja/screens/company/bloc/company_bloc.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_cubit.dart';
import 'package:system_loja/screens/configuracoes/bloc/user_cubit.dart';
import 'package:system_loja/screens/customer/bloc/customer_bloc.dart';
import 'package:system_loja/screens/route/route_app.dart';
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupAppInjection();
  runApp(const SystemLojaApp());
}

class SystemLojaApp extends StatelessWidget {
  const SystemLojaApp({super.key});

  @override
  Widget build(BuildContext context) {
    //sem add event aqui, apeans o bloc provider
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomerBloc>(
          create: (context) =>
              CustomerBloc(appInjection.get<ICustomerRepository>()),
        ),
        BlocProvider<CompanyBloc>(
          create: (context) =>
              CompanyBloc(appInjection.get<ICompanyRepository>()),
        ),
        BlocProvider<SalesCubit>(
          create: (context) => SalesCubit(
            appInjection.get<ISalesRepository>(),
            appInjection.get<ICustomerRepository>(),
            appInjection.get<IProductRepository>(),
          ),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(appInjection.get<IUserRepository>()),
        ),
        BlocProvider<LogsCubit>(
          create: (context) => LogsCubit(appInjection.get<ILogRepository>()),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: appInjection
            .get<SettingsService>()
            .currentThemeNotifier,
        builder: (context, value, child) {
          return MaterialApp.router(
            title: 'Sistema de Gerenciamento de Loja',
            theme: value,
            themeMode: appInjection.get<SettingsService>().temaEscuro
                ? ThemeMode.dark
                : ThemeMode.light,
            routerConfig: appInjection.get<RouteApp>().config(),
            debugShowCheckedModeBanner: kDebugMode,
          );
        },
      ),
    );
  }
}
